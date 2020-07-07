//
//  AnimatingServiceLocator.swift
//  OTUS-Practice
//
//  Created by Mak on 30.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

final class AnimatingServiceLocator {
    
    enum AnimatingTypeView {
        case diagram
        case tapAnimating
        
        func createView() -> some View {
            switch self {
            case .diagram:
                return AnyView(AnimatingDiagram())
            case .tapAnimating:
                return AnyView(TapAnimatig())
            }
        }
    }
    
    var diagramView: some View {
        self.initView(.diagram)
    }
    
    var tapAnimatingView: some View {
        self.initView(.tapAnimating)
    }
    
    func initView(_ type: AnimatingTypeView) -> some View {
        type.createView()
    }
}
