//
//  AnimeVM.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 12.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import Combine
import kotlinMP

final class AnimeVM: ObservableObject {
    
    private var bag = Set<AnyCancellable>()
    private let store: StoreProduct
    
    @Published var selected: Int? = nil
    @Published var query: String = ""
    @Published var lastAppearElement: Product = .naught
    
    @Published private(set) var list: Array<Product> = []
    @Published private(set) var isLoaded: Bool = true
    
    @Published var filter: String = ProductType.anime.rawValue
    var filters: Array<String>
    
    init() {
        filters = ProductType.allCases
            .map { $0.rawValue }
        
        store = StoreProduct()
        
        store.add { res in
            var tmpArr: Array<Product> = []
            print("LOG > result", res)
        }
        
        $query
            .filter { $0.count > 2 }
            .sink(receiveValue: getProduct(query:))
            .store(in: &bag)
    }
    
    private func getProduct(query: String) {
        store.set(filter: filter == "anime" ? .anime : .manga)
        store.set(query: query)
        store.dispatch(action: .search)
    }
    
}
