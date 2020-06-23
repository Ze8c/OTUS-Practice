//
//  NavVM.swift
//  OTUS-Practice
//
//  Created by Mak on 16.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

// MARK: - Enums

enum NavTransition {
    case none
    case custom(AnyTransition)
}

enum NavType {
    case push
    case pop
}

enum PopDestination {
    case previous
    case root
}

// MARK: - Model
// Model Node of Screen
struct Screen: Identifiable, Equatable {
    
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: -View Model
final class NavVM: ObservableObject {
    
    private let easing: Animation
    
    var navigationType: NavType = .push
    
    @Published var currentScreen: Screen?
    private var screenStack: ScreenStack = ScreenStack() {
        didSet {
            self.currentScreen = screenStack.top()
        }
    }
    
    // Init
    init(easing: Animation) {
        self.easing = easing
    }
    
    // API
    func push<S: View>(_ screenView: S) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screenView))
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination = .previous) {
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .root:
                screenStack.popToRoot()
            case .previous:
                screenStack.popToPrevious()
            }
        }
    }
    
    // Nested Stack Model
    
    private struct ScreenStack {
        
        private var screens = [Screen]()
        
        func top() -> Screen? {
            screens.last
        }
        
        mutating func push(_ s:Screen) {
            screens.append(s)
        }
        
        mutating func popToPrevious() {
            screens.removeLast()
        }
        
        mutating func popToRoot() {
            screens.removeAll()
        }
    }
}
