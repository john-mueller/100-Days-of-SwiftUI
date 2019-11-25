//
//  AboutHeightReader.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/25/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct AboutHeightReader: View {
    static let defaultHeight: CGFloat = .zero

    let string: String
    @Binding var height: CGFloat

    var body: some View {
        Text(self.string)
            .background(
                GeometryReader { geometry in
                    Rectangle()
                        .preference(key: Key.self, value: geometry.size.height)
            })
            .opacity(0)
            .onPreferenceChange(Key.self) { height in
                self.height = height
        }
    }

    private struct Key: PreferenceKey {
        static var defaultValue: CGFloat = AboutHeightReader.defaultHeight

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}
