//
//  TaskScheduler.swift
//  OTUS-Practice
//
//  Created by Mak on 10.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class TaskScheduler {
    
    private let queue: DispatchQueue?
    private let semafore: DispatchSemaphore
    private var tasks: Array<Task> = []
    
    var allTasksCompleted: Bool {
        for it in tasks {
            if !it.completed {
                return false
            }
        }
        return true
    }
    
    init(_ numberTasks: Int) {
        semafore = .init(value: numberTasks)
        queue = nil
    }
    
    init(name nameQueue: String = "", qos: DispatchQoS.QoSClass = .default, numberTasks: Int) {
        semafore = .init(value: numberTasks)
        
        if nameQueue.isEmpty {
            queue = DispatchQueue.global(qos: qos)
        } else {
            queue = DispatchQueue(label: nameQueue, qos: qos.value)
        }
    }
    
    @discardableResult
    func add(name: String = "", qos: DispatchQoS.QoSClass = .default, task: @escaping () -> (Structures, TimeInterval)) -> TaskScheduler {
        tasks.append(Task(name, qos, target: task))
        return self
    }
    
    @discardableResult
    func add(_ task: @escaping () -> (Structures, TimeInterval)) -> TaskScheduler {
        if let q = queue {
            tasks.append(Task(q, target: task))
        } else {
            print("LOG > queue is nil,", #function)
        }
        
        return self
    }
    
    func execute(async: @escaping ((Structures, TimeInterval)) -> Void) throws {
        
        if tasks.isEmpty {
            throw AppError("Tasks is empty")
        }
        
        tasks.forEach(execute(async: async))
    }
    
    private func execute(async: @escaping ((Structures, TimeInterval)) -> Void) -> (Task) -> Void {
        { [weak self] task in
            guard let self = self else { return }
            task.run(self.semafore, async: async)
        }
    }
}
