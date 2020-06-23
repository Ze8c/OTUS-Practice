//
//  AlgoTypesVM.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import SwiftUI

final class AlgoTypesVM: ObservableObject {
    
    @Published var list: Array<Structures> = []
    @Published var listTest: [Structures: (time: TimeInterval, color: Color)] = [:]
    @Published var disableToStart = false
    
    private var tmpDictionary: [Structures: (time: TimeInterval, color: Color)] = [:]
    private var testScheduler: TaskScheduler?
    
    init() {
        updateList()
    }
    
    func updateList(search: String = "") {
        if search.isEmpty {
            self.list =  Structures.allCases
        } else {
            self.list = Structures.allCases.filter { it in
                it.rawValue.lowercased().hasPrefix(search.lowercased())
            }
        }
    }
    
    func test() {
        tmpDictionary = [:]
        disableToStart = true
        
        testScheduler = TaskScheduler(name: "App.TestAlgo", qos: .background, numberTasks: 1)
        
        list.forEach { it in
            testScheduler?.add(testAlgo(it))
        }
        
        do {
            try testScheduler?.execute(async: execute(result:))
        } catch {
            print("LOG > ERROR:", error.localizedDescription)
        }
        
        disableToStart = false
    }
    
    private func testAlgo(_ alg: Structures) -> () -> (Structures, TimeInterval) {
        { (alg, alg.processor.setupWithObjectCount(10_000)) }
    }
    
    private func execute(result: (Structures, TimeInterval)) {
        tmpDictionary[result.0] = (time: result.1, color: .yellow)
        
        if testScheduler?.allTasksCompleted ?? false {
            setColor()
        }
    }
    
    private func setColor() {
        if let min = tmpDictionary.min(by: { $0.value.time < $1.value.time }) {
            tmpDictionary[min.key]?.color = .green
        }
        
        if let max = tmpDictionary.max(by: { $0.value.time < $1.value.time }) {
            tmpDictionary[max.key]?.color = .red
        }
        
        listTest = tmpDictionary
    }
}
