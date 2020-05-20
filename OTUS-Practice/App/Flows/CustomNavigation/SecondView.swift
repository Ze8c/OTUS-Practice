//
//  SecondView.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    var body: some View {
        VStack {
            NavControllerView(transition: .custom(.scale)) {
                NextFirstView(cellText: "Hello!!!")
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
