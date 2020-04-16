//
//  ServiceLocator.swift
//  OTUS-Practice
//
//  Created by Mak on 16.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class ServiceLocator {
    static let imlp = ServiceLocator()
    
    private var registry: [String: Any] = [:]
    
    private init() {}
    
    func register<T>(_ service: T) {
        registry[String(describing: T.self)] = service
    }
    
    func tryGet<T>() -> T? {
        registry[String(describing: T.self)] as? T
    }
}
