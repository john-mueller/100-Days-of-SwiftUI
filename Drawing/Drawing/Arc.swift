//
//  Arc.swift
//  Drawing
//
//  Created by John Mueller on 11/7/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ArcDemo: View {
    @State private var startAngle = 0.0
    @State private var endAngle = 90.0

    var body: some View {
        VStack {
        Arc(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 40)

        Text("Start angle: \(Int(startAngle))")
        Slider(value: $startAngle, in: 0...360, step: 1)
            .padding([.horizontal, .bottom])

        Text("End angle: \(Int(endAngle))")
        Slider(value: $endAngle, in: 0...360, step: 1)
            .padding(.horizontal)
        }
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment


        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2 - insetAmount,
                    startAngle: modifiedStart,
                    endAngle: modifiedEnd,
                    clockwise: !clockwise)
        return path
    }
}

struct ArcDemo_Previews: PreviewProvider {
    static var previews: some View {
        ArcDemo()
    }
}
