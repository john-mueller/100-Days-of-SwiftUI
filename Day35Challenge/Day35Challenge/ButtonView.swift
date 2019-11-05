//
//  ButtonView.swift
//  Day35Challenge
//
//  Created by John Mueller on 11/4/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    let colored: Bool
    var color: Color = .blue
    var action: () -> Void

    @State private var animation: Animation = nil

    var body: some View {
        ZStack {
            Capsule()
                .fill(colored ? color.opacity(0.8) : color.opacity(0.0001))
                .animation(animation)
            Capsule()
                .strokeBorder(lineWidth: 3, antialiased: true)
            Text(text)
                .font(.title)
        }
        .onTapGesture { self.action() }
        .onAppear {
            DispatchQueue.main.async {
                self.animation = .linear
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Text", colored: true) { }
    }
}
