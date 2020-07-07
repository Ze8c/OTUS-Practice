//
//  AlgoTestView.swift
//  OTUS-Practice
//
//  Created by Mak on 20.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct AlgoTestView: View {
    
    @EnvironmentObject var vm: AlgoTestVM
    
    @State private var value: Float = 0.22
    
    var body: some View {
        VStack {
            Text(vm.typeStructure.rawValue.capitalized)
                .font(.system(size: 35))
            
            slider()

            Text("Number of items: \(vm.getNumberOfItems(value)) \(vm.createElements)")
            Button(action: vm.startTest) {
                Text("Start test")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(5)
            }.disabled(vm.disableToStart)
            
            List(vm.list, id: \.0) { title, time in
                CellList(title: title, result: (time: time, color: .green))
            }
        } //VStack
    }
    
    private func slider() -> some View {
        
        #if os(tvOS)
        return EmptyView()
        #else
        return Slider(value: $value, in: 0.0001...1, step: 0.0001)
            .padding([.leading, .trailing], 50)
        #endif
    }
}

struct AlgoTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlgoTestView()
    }
}
