//
//  AnimeStoreAdaptor.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 12.07.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import Combine
import kotlinMP

final class AnimeStoreAdaptor: ObservableObject {
    
    private var bag = Set<AnyCancellable>()
    private let store: StoreProduct
    
    @Published var selected: Int? = nil
    @Published var query: String = ""
    @Published var lastAppearElement: ProductDB = .naught
    
    @Published private(set) var list: [ProductDB] = []
    @Published private(set) var isLoaded: Bool = true
    
    @Published var filter: String = ProductDBType.anime.rawValue
    var filters: Array<String>
    
    init() {
        filters = ProductDBType.allCases
            .map { $0.rawValue }
        
        store = StoreProduct()
        
        store.observer.add { [weak self] res in
            self?.list = res.map { ProductDB(kotlinModel: $0) }
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
