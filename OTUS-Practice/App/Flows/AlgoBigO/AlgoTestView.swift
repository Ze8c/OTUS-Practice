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
    
    @State private var value: Float = 0.5
    
    var body: some View {
        VStack {
            Text(vm.typeStructure.rawValue.capitalized)
                .font(.system(size: 35))
            Slider(value: $value, in: 0.0001...1, step: 0.0001)
                .padding([.leading, .trailing], 50)

            Text("Number of items: \(vm.getNumberOfItems(value)) \(vm.createElements)")
            Button(action: {
                self.vm.startTest()
            }) {
                Text("Start test")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.orange)
                    .cornerRadius(5)
            }.disabled(!vm.ableToStart)
            
            List(vm.list, id: \.0, rowContent: algoView)
        } //VStack
    }
    
    private func algoView(title: String, time: TimeInterval) -> some View {
        
        let strTime = String(ceil(time * 10000) / 10000)
        
        return HStack{
            Text(title)
            Spacer()
            Text(strTime)
        }
    }
}

struct AlgoTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlgoTestView()
    }
}
