//
//  AppError.swift
//  OTUS-Practice
//
//  Created by Mak on 11.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

struct AppError: Error {
    
    var string: String {
        value
    }
    
    private let value: String
    
    init(_ value: String) {
        self.value = value
    }
}
