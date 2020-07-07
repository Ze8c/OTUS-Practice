//
//  View3DVM.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 26.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class View3DVM: ObservableObject {
    
    var device: Renderer.Device {
        renderer.getDevice()
    }
    
    var texture: Renderer.Texture {
        renderer.setTexture("texture_forest.jpg")
    }
    
    private let renderer: Renderer
    
    init() {
        renderer = Renderer()
    }
}
