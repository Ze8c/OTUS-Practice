//
//  Renderer.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 26.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import Metal
import MetalKit

final class Renderer {
    
    typealias Device = MTLDevice
    typealias Texture = MTLTexture
    
    private let device: Device
    
    // Resources
    private var meshes: [MTKMesh] = []
    private var vertexDescriptor: MTLVertexDescriptor!
    private var texture: Texture!
    
    // Pipeline
    private var commandQueue: MTLCommandQueue!
    private var pipelineState: MTLRenderPipelineState!
    private var depthStencilState: MTLDepthStencilState!
    
    init() {
        self.device = MTLCreateSystemDefaultDevice()!
    }
    
    func getDevice() -> Device {
        device
    }
    
    func getTexture() -> Texture {
        texture
    }
    
    func setTexture(_ named: String) -> Texture! {
        guard let modelTexture = MDLTexture(named: named) else { return nil }
        let textureLoader = MTKTextureLoader(device: device)
        
        do {
            texture = try textureLoader.newTexture(texture: modelTexture, options: nil)
        } catch {
            print("loadResources texture ERROR")
            return nil
        }
        
        return texture
    }
    
    func loadResources() {
        let modelURL = Bundle.main.url(forResource: "teacup", withExtension: "obj")
        
        // Descriptor
        let vertexDecriptor = MDLVertexDescriptor()
        vertexDecriptor.attributes[0] = MDLVertexAttribute(name: MDLVertexAttributePosition, format: .float3, offset: 0, bufferIndex: 0)
        vertexDecriptor.attributes[1] = MDLVertexAttribute(name: MDLVertexAttributeTextureCoordinate, format: .float2, offset: MemoryLayout<Float>.size * 3, bufferIndex: 0)
        vertexDecriptor.layouts[0] = MDLVertexBufferLayout(stride: MemoryLayout<Float>.size * 5)
        self.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(vertexDecriptor)
        
        let bufferAllocator = MTKMeshBufferAllocator(device: device)
        let asset = MDLAsset(url: modelURL, vertexDescriptor: vertexDecriptor, bufferAllocator: bufferAllocator)
        var modelMeshes = [MDLMesh]()
        
        do {
            (modelMeshes, meshes) = try MTKMesh.newMeshes(asset: asset, device: device)
        } catch {
            print("loadResources texture ERROR")
            return
        }
        
        // Flip
        modelMeshes.first!.flipTextureCoordinates(inAttributeNamed: MDLVertexAttributeTextureCoordinate)
    }
    
    func buildPipeline() {
        // Depth Stencil
        let depthStencilDesc = MTLDepthStencilDescriptor()
        depthStencilDesc.depthCompareFunction = .less
        depthStencilDesc.isDepthWriteEnabled = true
        depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDesc)
        
        // Pipeline
        guard let library = device.makeDefaultLibrary() else {
            print("Error library")
            return
        }
        
        let vertexFunc = library.makeFunction(name: "tex_vertex")
        let fragmentFunc = library.makeFunction(name: "tex_fragment")
        
        let pipelineDesc = MTLRenderPipelineDescriptor()
        pipelineDesc.vertexDescriptor = vertexDescriptor
        pipelineDesc.vertexFunction = vertexFunc
        pipelineDesc.fragmentFunction = fragmentFunc
        pipelineDesc.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDesc.depthAttachmentPixelFormat = .depth32Float
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDesc)
        } catch {
            print("loadResources texture ERROR")
            return
        }
    }
}
