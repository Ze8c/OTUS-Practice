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
    private weak var service: AbstractServiceAPI?
    private let cache = Cache<Product, [Product]>()
    
    @Published var selected: Int? = nil
    @Published var query: String = ""
    @Published var lastAppearElement: Product = .naught
    
    @Published private(set) var list: Array<Product> = []
    @Published private(set) var isLoaded: Bool = true
    
    @Published var filter: String = ProductType.anime.rawValue
    var filters: Array<String>
    
    init(serviceAPI: AbstractServiceAPI) {
        self.service = serviceAPI
        
        filters = ProductType.allCases
            .map { $0.rawValue }
        
        $filter
            .sink { serviceAPI.tmpFilter = $0 }
            .store(in: &bag)
        
        $query
            .sink(receiveValue: serviceAPI.get)
            .store(in: &bag)
        
        serviceAPI.isLoadedPublisher
            .sink { self.isLoaded = $0 }
            .store(in: &bag)
        
        serviceAPI.listPublisher
            .sink { it in
                self.list = it
                self.cache.add(value: it)
            }
            .store(in: &bag)
        
        $lastAppearElement
            .sink(receiveValue: serviceAPI.nextPage)
            .store(in: &bag)
        
        cache.getValue()
            .sink { self.list = $0 ?? [] }
            .store(in: &bag)
    }
}
