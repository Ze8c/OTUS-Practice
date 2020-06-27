//
//  View3D.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 25.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct View3D: View {
    
    @EnvironmentObject var vm: View3DVM
    
    var body: some View {
        MTKViewUI(mtlDevice: vm.device, mtlTexture: vm.texture)
    }
}

struct View3D_Previews: PreviewProvider {
    static var previews: some View {
        View3D()
    }
}
