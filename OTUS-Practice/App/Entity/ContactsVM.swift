//
//  ContactsVM.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import SwiftUI

struct Contact: Identifiable {
    let id = UUID().uuidString
    let name: String
    let isRadish: Bool
    var activate: Bool = false
    
    var imgColor: Color {
        isRadish ? .red : .green
    }
    
    var imgName: String {
        isRadish ? "xmark.shield" : "checkmark.shield"
    }
}

final class ContactsVM: ObservableObject {
    
    @Published var selected: Int = 0
    
    @Published private(set) var btnName = "Bad people"
    
    @Published private(set) var list = [
        Contact(name: "1", isRadish: false),
        Contact(name: "2", isRadish: true),
        Contact(name: "3", isRadish: true),
        Contact(name: "4", isRadish: false),
        Contact(name: "5", isRadish: true),
        Contact(name: "6", isRadish: true),
        Contact(name: "7", isRadish: false),
        Contact(name: "8", isRadish: false),
        Contact(name: "9", isRadish: false),
        Contact(name: "10", isRadish: true),
        Contact(name: "11", isRadish: true),
        Contact(name: "12", isRadish: false),
        Contact(name: "13", isRadish: true),
        Contact(name: "14", isRadish: true),
        Contact(name: "15", isRadish: false),
        Contact(name: "16", isRadish: true),
        Contact(name: "17", isRadish: true),
        Contact(name: "18", isRadish: false),
        Contact(name: "19", isRadish: false),
        Contact(name: "20", isRadish: true),
        Contact(name: "21", isRadish: true)
    ]
    
    var selectedElement: Contact {
        list[selected]
    }
}
