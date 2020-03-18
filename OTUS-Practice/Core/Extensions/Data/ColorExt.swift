//
//  ColorExt.swift
//  OTUS-Practice
//
//  Created by Mak on 18.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

extension Color {
    
    public init(dRed: Double, green: Double, blue: Double) {
        self.init(red: dRed / 255, green: green / 255, blue: blue / 255)
    }
    
}
