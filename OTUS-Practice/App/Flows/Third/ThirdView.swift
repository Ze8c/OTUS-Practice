//
//  ThirdView.swift
//  OTUS-Practice
//
//  Created by Mak on 26.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct ThirdView: View {
    
    @State var isSwitch: Bool = false
    
    let serviceLocator = AnimatingServiceLocator()
    
    var contentView: some View {
        if isSwitch {
            return AnyView(serviceLocator.diagramView)
        } else {
            return AnyView(serviceLocator.tapAnimatingView)
        }
    }
    
    var body: some View {
        VStack {
            Toggle(isOn: $isSwitch) {
                Text("Switch View")
            }
            
            contentView
        }
    }
}
    

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
