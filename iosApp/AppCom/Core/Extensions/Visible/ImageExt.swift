//
//  ImageExt.swift
//  OTUS-Practice
//
//  Created by Mak on 26.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

extension Image {
    
    func imageFill() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
