//
//  NextFirstView.swift
//  OTUS-Practice
//
//  Created by Mak on 17.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct NextFirstView: View {
    
    var cellText: String
    
    var body: some View {
        VStack {
            Text("\(self.cellText)")
            
            NavPushButton(destination: NextSecondView()) {
                Text("Push to Screen №2")
            }
        }
    }
}
