//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by John Mueller on 11/7/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangleDemo: View {
    @State private var colorCycle = 0.0
    @State private var gradientLocation = 0.5

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle, location: gradientLocation)
                .frame(width: 300, height: 300)

            Group {
                HStack {
                    Text("Color shift")
                    Slider(value: $colorCycle)
                }

                HStack {
                    Text("Gradient location")
                    Slider(value: $gradientLocation, in: 0...1)
                }
            }
            .padding()
        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var location: Double

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: self.color(for: value, brightness: 1), location: 0),
                        Gradient.Stop(color: self.color(for: value, brightness: 0.75), location: CGFloat(self.location)),
                        Gradient.Stop(color: self.color(for: value, brightness: 0.5), location: 1)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleDemo()
    }
}
