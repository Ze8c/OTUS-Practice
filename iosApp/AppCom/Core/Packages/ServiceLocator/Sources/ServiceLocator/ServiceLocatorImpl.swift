//
//  ServiceLocatorImpl.swift
//  
//
//  Created by Mak on 29.04.2020.
//

import Foundation

public class Box {
    public var tmp: [String: () -> AnyObject] = [:]
    
    public func inject(_ abstraction: Any.Type, _  implementation: @escaping () -> AnyObject) {
        tmp[String(describing: abstraction.self)] = implementation
    }
}

public class ServiceLocatorImpl: ServiceLocator {
    
    private var registry: [String: () -> AnyObject] = [:]
    
    public init() {}
    
    public func register(_ service: Any) {
        registry[String(describing: service.self)] = { service as AnyObject }
    }
    
    public func registrator(component: (Box) -> Void) {
        let container = Box()
        component(container)
        container.tmp.forEach { (key, value) in self.registry[key] = value }
    }
    
    public func tryGet<T>() -> T? {
        registry[String(describing: T.self)]?() as? T
    }
}
