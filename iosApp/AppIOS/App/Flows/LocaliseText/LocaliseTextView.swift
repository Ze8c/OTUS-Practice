//
//  LocaliseTextView.swift
//  OTUS-Practice
//
//  Created by Mak on 13.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct LocaliseTextView: View {
    
    @EnvironmentObject var vm: LocaliseTextVM
    
    var body: some View {
        
        return VStack {
            Picker("Locales", selection: $vm.selectedLocale) {
                ForEach(vm.locales, id: \.self) { it in
                    Text(it.rawValue.capitalized)
                        .tag(it)
                }
            } //Picker
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 40)
                .padding(.horizontal, 10)
            
            txtView(withText: vm.secondText, align: .center)
                .padding(.top, 10)
            
            txtView(withText: vm.sharedText)
                .onAppear(perform: vm.getTxt)
            
            
            
            Spacer()
        } //VStack
    }
    
    func txtView(withText txt: String, align: TextAlignment = .leading) -> some View {
        Group {
            Text(txt)
                .multilineTextAlignment(align)
                .font(.body)
                .padding([.horizontal, .vertical], 20)
        } //Group
            .background(Color.white)
            .transition(.moveAndFade)
            .cornerRadius(12)
            .shadow(color: .gray, radius: 4, x: 1, y: 1)
            .padding([.top, .horizontal], 5)
    }
}

struct LocalizeTextView_Previews: PreviewProvider {
    static var previews: some View {
        LocaliseTextView()
            .environmentObject(LocaliseTextVM(withService: SharingService()))
    }
}
