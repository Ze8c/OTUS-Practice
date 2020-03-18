//
//  Spiner.swift
//  OTUS-Practice
//
//  Created by Mak on 18.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import UIKit
import SwiftUI
 
struct Spiner: UIViewRepresentable {
 
    func makeUIView(context: UIViewRepresentableContext<Spiner>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
 
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Spiner>) {
        uiView.startAnimating()
    }
}
