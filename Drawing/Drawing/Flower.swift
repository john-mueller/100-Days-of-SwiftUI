//
//  Flower.swift
//  Drawing
//
//  Created by John Mueller on 11/7/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct FlowerDemo: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .stroke(Color.red, lineWidth: 1)
                .fill(Color.red, style: FillStyle(eoFill: true))

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct Flower: Shape {
    var petalOffset: Double = -20

    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {

        var path = Path()

        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {

            let rotation = CGAffineTransform(rotationAngle: number)

            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2,
                                                                    y: rect.height / 2))

            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset),
                                                       y: 0,
                                                       width: CGFloat(petalWidth),
                                                       height: rect.width / 2))

            let rotatedPetal = originalPetal.applying(position)

            path.addPath(rotatedPetal)
        }

        return path
    }
}

struct FlowerDemo_Previews: PreviewProvider {
    static var previews: some View {
        FlowerDemo()
    }
}
