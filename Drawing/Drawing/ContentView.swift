//
//  ContentView.swift
//  Drawing
//
//  Created by John Mueller on 11/6/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            Form {
                ForEach(ViewType.allCases, id: \.self) { type in
                    NavigationLink("\(type.typeString)", destination:
                        self.getViewFor(type: type)
                            .navigationBarTitle("\(type.typeString)", displayMode: .inline)
                    )
                }
            }
            .navigationBarTitle("Drawing")
        }
    }
}

extension ContentView {
    func getViewFor(type: ViewType) -> AnyView {
        switch type {
        case .spirograph:
            return AnyView(SpirographDemo())
        case .checkerboard:
            return AnyView(CheckerboardDemo())
        case .trapezoid:
            return AnyView(TrapezoidDemo())
        case .blendMode:
            return AnyView(BlendModeDemo())
        case .colorCyclingCircle:
            return AnyView(ColorCyclingCircleDemo())
        case .flower:
            return AnyView(FlowerDemo())
        case .arc:
            return AnyView(ArcDemo())
        case .arrow:
            return AnyView(ArrowDemo())
        case .colorCyclingRectangle:
            return AnyView(ColorCyclingRectangleDemo())
        }
    }

    enum ViewType: String, CaseIterable {
        case spirograph, checkerboard, trapezoid, blendMode, colorCyclingCircle, flower, arc, arrow, colorCyclingRectangle

        var typeString: String {
            rawValue.prefix(1).uppercased() + rawValue.dropFirst() + " Demo"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
