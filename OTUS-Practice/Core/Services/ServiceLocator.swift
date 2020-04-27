//
//  ServiceLocator.swift
//  OTUS-Practice
//
//  Created by Mak on 16.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class Container {
    var tmp: [String: AnyObject] = [:]
    
    func inject(_ abstraction: Any.Type, _  implementation: () -> AnyObject) {
        tmp[String(describing: abstraction.self)] = implementation()
    }
}

final class ServiceLocator {
    static let imlp = ServiceLocator()
    
    private var registry: [String: AnyObject] = [:]
    
    private init() {}
    
    func register(_ service: Any) {
        registry[String(describing: service.self)] = service as AnyObject
    }
    
    func registrator(component: (Container) -> Void) {
        let container = Container()
        component(container)
        container.tmp.forEach { (key, value) in self.registry[key] = value }
    }
    
    func tryGet<T>() -> T? {
        registry[String(describing: T.self)] as? T
    }
}
