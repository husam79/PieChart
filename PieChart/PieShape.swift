//
//  PieShape.swift
//  TestArc
//
//  Created by Husam Burhan on 28.12.2022.
//

import SwiftUI
import Foundation

struct PieShape: Shape{
    var startAngle: Double
    var percent: Double
    
    init(startAngle: Double, percent: Double) {
        self.startAngle = startAngle
        self.percent = percent
    }
    
    func path(in rect: CGRect) -> Path {
        let center      = CGPoint(x: rect.midX, y: rect.midY)
        let radius      = min(rect.width, rect.height) / 2
        let endAngle    = percent / 100 * 360 + startAngle
        
        return Path { path in
            path.move(to: center)

            path.addArc(center: center,
                        radius: radius,
                        startAngle: Angle(degrees: startAngle),
                        endAngle: Angle(degrees: endAngle),
                        clockwise: false)
            
            path.closeSubpath()
        }
    }
}
