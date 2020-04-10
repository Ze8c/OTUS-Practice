//
//  ServiceAPI.swift
//  OTUS-Practice
//
//  Created by Mak on 08.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import Combine

protocol AbstractServiceAPI: class {
    var tmpFilter: String { get set }
    
    var isLoaded: Bool { get }
    var isLoadedPublished: Published<Bool> { get }
    var isLoadedPublisher: Published<Bool>.Publisher { get }
    
    var list: Array<Product> { get }
    var listPublished: Published<Array<Product>> { get }
    var listPublisher: Published<Array<Product>>.Publisher { get }
    
    func get(_ query: String) -> Void
    func nextPage(lastIt: Product)
}

final public class ServiceAPIImpl: ObservableObject, AbstractServiceAPI {
    
    var tmpFilter: String = ""
    
    @Published private(set) var list: Array<Product> = []
    var listPublished: Published<Array<Product>> { _list }
    var listPublisher: Published<Array<Product>>.Publisher { $list }
    
    @Published private(set) var isLoaded: Bool = true
    var isLoadedPublished: Published<Bool> { _isLoaded }
    var isLoadedPublisher: Published<Bool>.Publisher { $isLoaded }
    
    private let queryQueue: DispatchQueue = .global(qos: .background)
    
    private var lastPage: Int = 1
    private var page: Int = 1
    private var tmpQuery: String = ""
    
    func get(_ query: String) -> Void {
        self.tmpQuery = query
        self.list = []
        self.page = 1
        self.lastPage = 1
        self.nextPage(lastIt: .naught)
    }
    
    func nextPage(lastIt: Product) {
        guard isLoaded, list.isLast(lastIt), !tmpQuery.isEmpty else { return }
        
        isLoaded = false
        
        if page <= lastPage {
            SearchAnimeAPI.getAnime(q: tmpQuery,
                                    page: page,
                                    filter: tmpFilter,
                                    apiResponseQueue: queryQueue) { [weak self] (it) in
                
                guard let items = it?.results else { return }
                                        
                DispatchQueue.main.async {
                    self?.list.append(contentsOf: items)
                    self?.lastPage = it?.lastPage ?? 1
                    self?.page += 1
                    self?.isLoaded = true
                }
            }
        }
    }
}
