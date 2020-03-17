//
//  ColumnView.swift
//  OTUS-Practice
//
//  Created by Mak on 12.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct ColumnView: View {
    
    @EnvironmentObject var vm: ColumnVM
    
    @State var isModal: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(vm.elements.indices, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(self.vm.elements[row], id: \.self) { cellInf in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.orange)
                                    .onTapGesture {
                                        self.isModal = true
                                    }
                                    .sheet(isPresented: self.$isModal, content: {
                                        Text("Inside content")
                                    })
                                Text("\(cellInf)")
                            } //ZStack - cell
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                        }
                    } //HStack - row
                }
            } //VStack - column
        } //ScrollView
            .padding(.horizontal, 20)
    }
}

struct ColumnView_Previews: PreviewProvider {
    static var previews: some View {
        ColumnView()
            .environmentObject(ColumnVM())
    }
}
