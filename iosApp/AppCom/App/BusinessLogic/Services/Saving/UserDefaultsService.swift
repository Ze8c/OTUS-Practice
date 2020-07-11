//
//  UserDefaultsService.swift
//  OTUS-Practice
//
//  Created by Mak on 21.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class UserDefaultsService: DataProvider {
    
    private let provider: UserDefaults?
    
    init(with ud: UserDefaults? = UserDefaults(suiteName: "group.com.otus-pracitce.my")) {
        provider = ud
    }
    
    func set(to key: String, value: String) {
        provider?.set(value, forKey: key)
    }
    
    func get(from key: String) -> String {
        return provider?.string(forKey: key) ?? ""
    }
}
