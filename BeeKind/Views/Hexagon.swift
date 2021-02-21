// Copyright © 2021 acicartagena. All rights reserved.
// Code from: https://github.com/spacenation/swiftui-shapes

import Foundation
import SwiftUI

struct Hexagon: Shape {
    private let inset: CGFloat

    func path(in rect: CGRect) -> Path {
        Path.hexagon(in: rect, inset: inset)
    }

    init(inset: CGFloat = 0) {
        self.inset = inset
    }
}

extension Path {
    static func hexagon(in rect: CGRect, inset: CGFloat = 0.0) -> Path {
        let sides = 6
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let hypotenuse = Double(min(width, height)) / 2.0
        let centerPoint = CGPoint(x: width / 2.0, y: height / 2.0)

        return Path { path in
            (0...sides).forEach { index in
                let angle = ((Double(index) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                let point = CGPoint(
                    x: centerPoint.x + CGFloat(cos(angle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(angle) * hypotenuse)
                )
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
        }
        .offsetBy(dx: inset, dy: inset)
    }
}
