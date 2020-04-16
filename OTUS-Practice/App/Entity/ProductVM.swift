//
//  ProductVM.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import Combine

final class ProductVM: ObservableObject {
    
    private var bag = Set<AnyCancellable>()
    private weak var service: AbstractAnimeAPI?
    private let cache = Cache<Product, [Product]>()
    
    @Published var selected: Int? = nil
    @Published var query: String = ""
    @Published var lastAppearElement: Product = .naught
    
    @Published private(set) var list: Array<Product> = []
    @Published private(set) var isLoaded: Bool = true
    
    @Published var filter: String = ProductType.anime.rawValue
    var filters: Array<String>
    
    init(serviceAPI: AbstractAnimeAPI?) {
        self.service = serviceAPI
        
        filters = ProductType.allCases
            .map { $0.rawValue }
        
        guard let service = serviceAPI else { return }
        
        $filter
            .sink { service.tmpFilter = $0 }
            .store(in: &bag)
        
        $query
            .filter { $0.count > 2 }
            .compactMap(service.get)
            .sink(receiveValue: resFlag)
            .store(in: &bag)
        
        $lastAppearElement
            .filter { _ in service.listInit }
            .map(service.nextPage)
            .sink(receiveValue: result(_:))
            .store(in: &bag)
        
        cache.getValue()
            .sink { self.list = $0 ?? [] }
            .store(in: &bag)
    }
    
    private func resFlag(_ v: Published<Array<Product>>.Publisher, _ f: Published<Bool>.Publisher) {
        f.sink { self.isLoaded = $0 }.store(in: &bag)
        
        result(v)
    }
    
    private func result(_ v: Published<Array<Product>>.Publisher) {
        v.sink(receiveValue: cache.add(value:)).store(in: &bag)
        v.sink { self.list = $0 }.store(in: &bag)
    }
}
