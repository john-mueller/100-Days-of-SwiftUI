//
//  ViewModel.swift
//  Day19Challenge
//
//  Created by John Mueller on 10/11/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct Unit {
    var name: String
    var abbreviation: String
    var unit: Dimension
}

class ViewModel: ObservableObject {
    @Published var typeIndex: Int = 0 {
        willSet {
            inputUnitIndex = 0
            outputUnitIndex = 1
        }
    }
    @Published var inputUnitIndex: Int = 0
    @Published var outputUnitIndex: Int = 1

    @Published var amount: String = ""

    var convertedValue: String {
        guard let doubleValue = Double(amount) else { return "" }

        let measurement = Measurement(value: doubleValue, unit: units[typeIndex][inputUnitIndex].unit)

        let convertedMeasurement = measurement.converted(to: units[typeIndex][outputUnitIndex].unit)

        return String(format: "%g", convertedMeasurement.value)
    }

    var headerString: String {
        "Convert from \(units[typeIndex][inputUnitIndex].name) to \(units[typeIndex][outputUnitIndex].name)"
    }

    let types = ["Temp", "Length", "Time", "Volume"]

    let units = [
        [
            Unit(name: "degrees Celsius", abbreviation: "°C", unit: UnitTemperature.celsius),
            Unit(name: "degrees Fahrenheit", abbreviation: "°F", unit: UnitTemperature.fahrenheit),
            Unit(name: "kelvins", abbreviation: "K", unit: UnitTemperature.kelvin)
        ],
        [
            Unit(name: "meters", abbreviation: "m", unit: UnitLength.meters),
            Unit(name: "kilometers", abbreviation: "km", unit: UnitLength.kilometers),
            Unit(name: "feet", abbreviation: "ft", unit: UnitLength.feet),
            Unit(name: "yards", abbreviation: "yd", unit: UnitLength.yards),
            Unit(name: "miles", abbreviation: "mi", unit: UnitLength.miles)
        ],
        [
            Unit(name: "seconds", abbreviation: "s", unit: UnitDuration.seconds),
            Unit(name: "minutes", abbreviation: "min", unit: UnitDuration.minutes),
            Unit(name: "hours", abbreviation: "h", unit: UnitDuration.hours),
            Unit(name: "days", abbreviation: "d", unit: UnitDuration.days)
        ],
        [
            Unit(name: "milliliters", abbreviation: "ml", unit: UnitVolume.milliliters),
            Unit(name: "liters", abbreviation: "l", unit: UnitVolume.liters),
            Unit(name: "cups", abbreviation: "c", unit: UnitVolume.cups),
            Unit(name: "pints", abbreviation: "pt", unit: UnitVolume.pints),
            Unit(name: "gallons", abbreviation: "gal", unit: UnitVolume.gallons)
        ]
    ]
}

extension UnitDuration {
    static var days: UnitDuration {
        return UnitDuration(symbol: "day", converter: UnitConverterLinear(coefficient: 3600 * 24))
    }
}
