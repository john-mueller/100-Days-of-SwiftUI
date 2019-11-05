//
//  SetupView.swift
//  Day35Challenge
//
//  Created by John Mueller on 11/4/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct SetupView: View {
    @EnvironmentObject var model: Model
    
    var allEnabled: Bool {
        model.enabledTables.count == model.enabledTables.filter { $0 }.count
    }
    
    var allDisabled: Bool {
        model.enabledTables.filter { $0 }.isEmpty
    }
    
    var body: some View {
        VStack {
            Section(header: Text("Which tables to review?").font(.title)) {
                VStack(spacing: model.rowSpacing) {
                    HStack(spacing: model.rowSpacing) {
                        ButtonView(text: "All", colored: allEnabled) {
                            self.model.enabledTables = Array(repeating: true, count: self.model.enabledTables.count)
                        }
                        
                        ButtonView(text: "None", colored: allDisabled) {
                            self.model.enabledTables = Array(repeating: false, count: self.model.enabledTables.count)
                        }
                    }
                    .frame(height: model.rowHeight)
                    
                    ForEach(0..<3, id: \.self) { row in
                        HStack(spacing: self.model.rowSpacing) {
                            ForEach(0..<4, id: \.self) { column in
                                GeometryReader { geometry in
                                    ButtonView(text: "\(row * 4 + column + 1)", colored: self.model.enabledTables[row * 4 + column]) {
                                        self.model.enabledTables[row * 4 + column].toggle()
                                    }
                                }
                            }
                        }
                        .frame(height: self.model.rowHeight)
                    }
                }
            }
            
            Spacer()
            
            Section(header: Text("How many questions?").font(.title)) {
                HStack(spacing: model.rowSpacing) {
                    ForEach(NumberSelection.allCases, id: \.self) { number in
                        ButtonView(text: number.description, colored: number == self.model.numberSelection) {
                            self.model.numberSelection = number
                        }
                    }
                }
                .frame(height: model.rowHeight)
            }
            
            Spacer()
            
            ButtonView(text: "Play!", colored: true, color: allDisabled ? .gray : .green) {
                withAnimation(.default) {
                    self.model.gameState = .playing
                }
            }
            .frame(height: model.rowHeight)
            .disabled(allDisabled)
        }
        .padding(model.rowSpacing)
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
