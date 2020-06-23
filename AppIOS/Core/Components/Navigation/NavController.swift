//
//  NavController.swift
//  OTUS-Practice
//
//  Created by Mak on 16.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct NavControllerView<Content>: View where Content: View {
    
    @ObservedObject private var vm: NavVM
    
    private let content: Content
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    init(transition: NavTransition,
         easing: Animation = .easeOut(duration: 0.33),
         @ViewBuilder content: () -> Content)
    {
        self.vm = NavVM(easing: easing)
        self.content = content()
        switch transition {
        case let .custom(trans):
            self.transitions = (trans, trans)
        case .none:
            self.transitions = (.identity, .identity)
        }
    }
    
    var body: some View {
        let isRoot = vm.currentScreen == nil
        return ZStack {
            if isRoot {
                content
                    .transition(vm.navigationType == .push ? transitions.push : transitions.pop )
                    .environmentObject(vm)
            } else {
                vm.currentScreen!.nextScreen
                    .transition(vm.navigationType == .push ? transitions.push : transitions.pop )
                    .environmentObject(vm)
            }
        }
    }
    
}
