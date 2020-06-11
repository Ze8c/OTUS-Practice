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
    
    private var maxTime: Double = -1
    private var minTime: Double = 100_000
    
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
        disableToStart = true
        maxTime = -1
        minTime = 100_000
        
        let testScheduler = TaskScheduler(name: "App.TestAlgo", qos: .background, numberTasks: 1)
        
        list.forEach { it in
            testScheduler.add(testAlgo(it))
        }
        
        do {
            try testScheduler.execute { [weak self] result in
                guard let self = self else { return }
                
                var resColor: Color = .yellow
                
                if self.maxTime < result.1 {
                    self.maxTime = result.1
                    resColor = .red
                }
                
                if self.minTime > result.1 {
                    self.minTime = result.1
                    resColor = .green
                }
                
                self.listTest[result.0] = (time: result.1, color: resColor)
            }
            setColot()
        } catch {
            print("LOG > ERROR:", error.localizedDescription)
        }
        
        disableToStart = false
    }
    
    private func testAlgo(_ alg: Structures) -> () -> (Structures, TimeInterval) {
        { (alg, alg.processor.setupWithObjectCount(10_000)) }
    }
    
    private func setColot() {
        
    }
}
