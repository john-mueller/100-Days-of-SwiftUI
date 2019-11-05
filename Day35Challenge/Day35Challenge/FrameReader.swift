//
//  FrameReader.swift
//  Day35Challenge
//
//  Created by John Mueller on 11/4/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct FrameReader: View {
    @EnvironmentObject var model: Model

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .offset(geometry.size)
                .preference(key: FrameReader.self, value: geometry.size)
                .onPreferenceChange(FrameReader.self) {
                    self.model.frameSize = $0
            }
        }
    }
}

extension FrameReader: PreferenceKey {
    public static var defaultValue: CGSize {
        .zero
    }

    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct FrameReader_Previews: PreviewProvider {
    static var previews: some View {
        FrameReader()
    }
}
