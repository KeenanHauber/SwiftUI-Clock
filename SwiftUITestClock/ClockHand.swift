//
//  ClockHand.swift
//  SwiftUITestClock
//
//  Created by Keenan Hauber on 14/4/21.
//

import SwiftUI

struct ClockHand: Shape {
    func path(in rect: CGRect) -> Path {
        return Path({ path in
            let length = min(rect.midY, rect.midX) * scale
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLine(to: CGPoint(
                x: rect.midX + sin(CGFloat.tau * (value / increments)) * length,
                y: rect.midY + cos(CGFloat.tau * (value / increments)) * length * -1
            ))
        })
    }

    let value: CGFloat
    let increments: CGFloat
    let scale: CGFloat
}
