//
//  ProductVM.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import SwiftUI

final class ProductVM: ObservableObject {
    
    @Published var selected: Int? = nil
    
    @Published private(set) var btnName = "Bad people"
    
    @Published private(set) var list: Array<Product> = []
    @Published private(set) var page: Int = 1
    @Published private(set) var isLoaded: Bool = true
    
    private var lastPage: Int = 1
    
    private var tmpFilter: String = ""
    private var tmpQuery: String = ""
    
    func getAnime(_ query: String = "", filter: String = "") {
        if !(query.isEmpty || filter.isEmpty) {
            tmpFilter = filter
            tmpQuery = query
            list = []
            page = 1
            lastPage = 1
        }
        
        guard isLoaded, !query.isEmpty || !tmpQuery.isEmpty else { return }
        
        isLoaded.toggle()
        
        if page <= lastPage {
            SearchAnimeAPI.getAnime(q: tmpQuery,
                                    page: page,
                                    filter: tmpFilter,
                                    apiResponseQueue: .global(qos: .background))
            { [weak self] (it, error) in
                
                guard let items = it?.results else { return }
                DispatchQueue.main.async {
                    //print("[LOG] -> ", items[0])
                    self?.list.append(contentsOf: items)
                    self?.lastPage = it?.lastPage ?? 1
                    self?.page += 1
                    self?.isLoaded = true
                }
            }
        }
    }
}
