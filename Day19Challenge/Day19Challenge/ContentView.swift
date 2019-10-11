//
//  ContentView.swift
//  Day19Challenge
//
//  Created by John Mueller on 10/11/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModel()

    var body: some View {
        Form {
            Section(header: Text("Select conversion type")) {
                Picker("Select conversion type", selection: $model.typeIndex) {
                    ForEach(model.types.indices, id: \.self) { typeIndex in
                        Text(self.model.types[typeIndex])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text(model.headerString)) {
                Picker("Source unit", selection: $model.inputUnitIndex) {
                    ForEach(self.model.units[self.model.typeIndex].indices, id: \.self) { unitIndex in
                        Text(self.model.units[self.model.typeIndex][unitIndex].abbreviation)
                    }
                }.pickerStyle(SegmentedPickerStyle())

                Picker("Destination unit", selection: $model.outputUnitIndex) {
                    ForEach(self.model.units[self.model.typeIndex].indices, id: \.self) { unitIndex in
                        Text(self.model.units[self.model.typeIndex][unitIndex].abbreviation)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }

            Section {
                TextField("Enter an amount", text: $model.amount)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("Result")) {
                Text(model.convertedValue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
