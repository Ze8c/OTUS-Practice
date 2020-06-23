//
//  ServiceAPI.swift
//  OTUS-Practice
//
//  Created by Mak on 08.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import Combine

protocol AbstractAnimeAPI: class {
    var tmpFilter: String { get set }
    var listInit: Bool { get }
    func get(_ query: String) -> (v: Published<Array<Product>>.Publisher, f: Published<Bool>.Publisher)
    func nextPage(lastIt: Product) -> Published<Array<Product>>.Publisher
}

final public class AnimeAPIImpl: AbstractAnimeAPI {
    
    var tmpFilter: String = ""
    
    @Published private var list: Array<Product> = []
    @Published private var isLoaded: Bool = false
    
    private let queryQueue: DispatchQueue = .global(qos: .background)
    
    private var lastPage: Int = 1
    private var page: Int = 1
    private var tmpQuery: String = ""
    
    var listInit: Bool {
        list.count > 0
    }
    
    func get(_ query: String) -> (v: Published<Array<Product>>.Publisher, f: Published<Bool>.Publisher) {
        self.tmpQuery = query
        self.list = []
        self.page = 1
        self.lastPage = 1
        self.isLoaded = true
        return (v: self.nextPage(lastIt: .naught), f: $isLoaded)
    }
    
    func nextPage(lastIt: Product) -> Published<Array<Product>>.Publisher {
        guard isLoaded, list.isLast(lastIt), !tmpQuery.isEmpty else { return $list }
        
        isLoaded = false
        
        if page <= lastPage {
            SearchAnimeAPI.getAnime(q: tmpQuery,
                                    page: page,
                                    filter: tmpFilter,
                                    apiResponseQueue: queryQueue) { [weak self] (it) in
                
                guard let items = it?.results else { return }
                
                self?.lastPage = it?.lastPage ?? 1
                self?.page += 1
                
                DispatchQueue.main.async {
                    self?.list.append(contentsOf: items)
                    self?.isLoaded = true
                }
            }
        }
        return $list
    }
}
