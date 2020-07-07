//
//  Task.swift
//  OTUS-Practice
//
//  Created by Mak on 10.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class Task {
    
    private(set) var completed: Bool = false
    
    private let queue: DispatchQueue
    private let queueResult: DispatchQueue
    private let target: () -> (Structures, TimeInterval)
    
    init(_ nameQueue: String = "", _ qos: DispatchQoS.QoSClass = .default, target: @escaping () -> (Structures, TimeInterval)) {
        
        if nameQueue.isEmpty {
            queue = DispatchQueue.global(qos: qos)
        } else {
            queue = DispatchQueue(label: nameQueue, qos: qos.value)
        }
        
        self.queueResult = .main
        self.target = target
    }
    
    init(_ queue: DispatchQueue, target: @escaping () -> (Structures, TimeInterval)) {
        self.queue = queue
        self.queueResult = .main
        self.target = target
    }
    
    func run(_ semafore: DispatchSemaphore = DispatchSemaphore(value: 1),
             async: @escaping ((Structures, TimeInterval)) -> Void) {
        
        queue.async { [weak self] in
            
            guard let self = self else { return }
            self.completed = false
            
            let result = self.target()
            
            self.queueResult.async {
                self.completed = true
                async(result)
            }
            
            semafore.signal()
        }
        semafore.wait()
    }
}
