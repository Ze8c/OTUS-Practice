//
//  NavPushButton.swift
//  OTUS-Practice
//
//  Created by Mak on 16.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct NavPushButton<Label, Destination>: View where Label: View, Destination: View {
    
    @EnvironmentObject private var vm: NavVM
    
    private let destination: Destination
    private let label: Label

    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        self.label.onTapGesture {
            self.push()
        }
    }
    
    private func push() {
        self.vm.push(self.destination)
    }
}
