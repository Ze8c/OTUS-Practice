//
//  PathDiagram.swift
//  OTUS-Practice
//
//  Created by Mak on 30.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import SwiftUI

struct PathDiagram: Shape {
    
    var data = [(CGFloat, CGFloat)]() // tuples
    
    init(data: [(CFTimeInterval, CGFloat)]) {
        guard let last = data.last else { return }
        let maxX = last.0
        let slice = data.drop { $0.0 < maxX - 3 }
        guard let minX = slice.first?.0 else { return }
        self.data = slice.map {
            (CGFloat(($0.0 - maxX) / (minX - maxX)), $0.1)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        guard !data.isEmpty else { return Path() }
        let points = data.map { CGPoint(x: $0.0 * rect.width, y: $0.1 * rect.height)}
        return Path { p in
            p.move(to: points[0])
            p.addLines(points)
        }
    }
}
