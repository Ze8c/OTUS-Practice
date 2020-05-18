//
//  DataProvider.swift
//  OTUS-Practice
//
//  Created by Mak on 15.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

protocol DataProvider {
    func set(to key: String, value: String)
    func get(from key: String) -> String
}
