//
//  ServiceLocator.swift
//  
//
//  Created by Mak on 29.04.2020.
//

import Foundation

public protocol ServiceLocator {
    func register(_ service: Any)
    func registrator(component: (Box) -> Void)
    func tryGet<T>() -> T?
}
