//
//  AnimeVM.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import SwiftUI

final class AnimeVM: ObservableObject {
    
    @Published var selected: Int? = nil
    
    @Published private(set) var btnName = "Bad people"
    
    @Published private(set) var list: Array<Anime> = []
    @Published private(set) var page: Int = 1
    @Published private(set) var isLoaded: Bool = true
    
    func getAnime() {
        guard isLoaded else { return }
        
        if page == 1 {
            list = []
        }
        
        isLoaded.toggle()
        
        SearchAnimeAPI.getAnime(q: "Darck", page: page, apiResponseQueue: .global(qos: .background)) { [weak self] (it, error) in
            guard let items = it?.results else { return }
            DispatchQueue.main.async {
                self?.list.append(contentsOf: items)
                self?.page += 1
                self?.isLoaded = true
            }
        }
    }
}
