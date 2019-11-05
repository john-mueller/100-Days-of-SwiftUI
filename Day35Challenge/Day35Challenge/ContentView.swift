//
//  ContentView.swift
//  Day35Challenge
//
//  Created by John Mueller on 10/28/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = Model()

    var body: some View {
        ZStack {
            FrameReader()

            if model.gameState == .setup {
                SetupView()
            } else {
                GameView()
            }
        }
        .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
