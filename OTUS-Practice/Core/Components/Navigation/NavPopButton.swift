//
//  NavPopButton.swift
//  OTUS-Practice
//
//  Created by Mak on 16.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct NavPopButton<Label>: View where Label: View {
    
    @EnvironmentObject private var vm: NavVM
    
    private let destination: PopDestination
    private let label: Label
    
    init(destination: PopDestination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        self.label.onTapGesture {
            self.pop()
        }
    }
    
    private func pop() {
        self.vm.pop(to: self.destination)
    }
    
}
