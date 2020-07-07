//
//  MTKViewUI.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 24.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import AVFoundation
import Metal
import MetalKit
import SwiftUI
import UIKit

struct MTKViewUI: UIViewRepresentable {
    
    private let coordinator: Coordinator
    
    private let base: MTKView = {
        $0.preferredFramesPerSecond = 60
        $0.isOpaque = true
        $0.enableSetNeedsDisplay = true
        $0.framebufferOnly = false
        $0.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        $0.device = MTLCreateSystemDefaultDevice()
        $0.drawableSize = $0.frame.size
        $0.enableSetNeedsDisplay = true
        return $0
    }(MTKView())
    
    init(mtlDevice device: MTLDevice, mtlTexture texture: MTLTexture) {
        coordinator = Coordinator(mtlDevice: device, mtlTexture: texture)
        base.device = device
    }
    
    func makeCoordinator() -> Coordinator {
        coordinator
    }
    
    func makeUIView(context: UIViewRepresentableContext<MTKViewUI>) -> MTKView {
        base.delegate = context.coordinator
        base.backgroundColor = context.environment.colorScheme == .dark ? .white : .white
        return base
    }
    
    func updateUIView(_ uiView: MTKView, context: UIViewRepresentableContext<MTKViewUI>) {
    }
    
    internal final class Coordinator: NSObject, MTKViewDelegate {
        
        private let device: MTLDevice
        
        private let ciContext: CIContext!
        
        private let commandQueue: MTLCommandQueue!
        private var baseTexture: MTLTexture
        
        var startTime: Date!
        
        init(mtlDevice device: MTLDevice, mtlTexture texture: MTLTexture) {
            self.device = device
            self.ciContext = CIContext(mtlDevice: device)
            self.commandQueue = device.makeCommandQueue()
            
            self.baseTexture = texture
            
            super.init()
        }

        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
            
        }
        
        func draw(in view: MTKView) {
            
            guard let drawable = view.currentDrawable else { return }
            
            let commandBuffer = commandQueue.makeCommandBuffer()
            let inputImage = CIImage(mtlTexture: baseTexture)!
            var size = view.bounds
            size.size = view.drawableSize
            size = AVMakeRect(aspectRatio: inputImage.extent.size, insideRect: size)
            let filteredImage = inputImage.transformed(by: CGAffineTransform(
                scaleX: size.size.width/inputImage.extent.size.width,
                y: size.size.height/inputImage.extent.size.height))//.rotated(by: .pi))
            let x = -size.origin.x
            let y = -size.origin.y
            
            self.baseTexture = drawable.texture
            ciContext.render(filteredImage,
                to: drawable.texture,
                commandBuffer: commandBuffer,
                bounds: CGRect(origin: CGPoint(x: x, y: y), size: view.drawableSize),
                colorSpace: CGColorSpaceCreateDeviceRGB())

            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
        
        func getUIImage(texture: MTLTexture, context: CIContext) -> UIImage?{
            let kciOptions = [CIImageOption.colorSpace: CGColorSpaceCreateDeviceRGB(),
                              CIContextOption.outputPremultiplied: true,
                              CIContextOption.useSoftwareRenderer: false] as! [CIImageOption : Any]
            
            if let ciImageFromTexture = CIImage(mtlTexture: texture, options: kciOptions) {
                if let cgImage = context.createCGImage(ciImageFromTexture, from: ciImageFromTexture.extent) {
                    let uiImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .downMirrored)
                    return uiImage
                }else{
                    return nil
                }
            }else{
                return nil
            }
        }
    }
}
