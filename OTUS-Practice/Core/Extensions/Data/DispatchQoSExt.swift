//
//  DispatchQoSExt.swift
//  OTUS-Practice
//
//  Created by Mak on 11.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

extension DispatchQoS.QoSClass {
    
    var value: DispatchQoS {
        let result: DispatchQoS
        
        switch self {
        case .background:
            result = .background
        case .utility:
            result = .utility
        case .default:
            result = .default
        case .userInitiated:
            result = .userInitiated
        case .userInteractive:
            result = .userInteractive
        case .unspecified:
            result = .unspecified
        @unknown default:
            result = .default
        }
        
        return result
    }
}
