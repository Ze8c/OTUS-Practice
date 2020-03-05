//
//  SwitchCell.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct SwitchCell: View {
    
    @EnvironmentObject var vm: ContactsVM
    
    @Binding var radish: Bool
    
    var body: some View {
        Toggle(isOn: $radish) {
            Text(vm.btnName)
        }
    }
}
