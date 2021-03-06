//
//  AnimatingDiagram.swift
//  OTUS-Practice
//
//  Created by Mak on 30.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct AnimatingDiagram: View {
    
    @State var diagramSwitch: Bool = false
    
    @State var diagramDatas = [(CFTimeInterval, CGFloat)]()
    
    var animation: Animation {
        Animation.interactiveSpring(response: 0.82, dampingFraction: 0.3, blendDuration: 0.1)
        .speed(1.5)
        .delay(0.3)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Circle()
                .fill(Color.purple)
                .frame(width: (diagramSwitch ? 100 : 44), height: 200)
                .modifier(DiagramEffect(callback: { value in
                    DispatchQueue.main.async {
                        self.diagramDatas.append((CACurrentMediaTime(), value))
                    }
                }, animatableData: diagramSwitch ? 1.0 : 0.0 ))
                .animation(animation)
            
            PathDiagram(data: diagramDatas)
                .stroke(Color.green, lineWidth: 2)
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .border(Color.gray, width: 1)
            
            Button(action: {self.diagramSwitch.toggle()}) {
                Text("Left/Right")
            }
        }
        .padding(.horizontal, 20)
        
    }
}

struct AnimatingDiagram_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingDiagram()
    }
}
