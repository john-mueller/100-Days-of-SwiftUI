//
//  NumberSelection.swift
//  Day35Challenge
//
//  Created by John Mueller on 11/4/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import Foundation

enum NumberSelection: CaseIterable, CustomStringConvertible {
    case five, ten, twenty, all

    var description: String {
        switch self {
        case .five:
            return "5"
        case .ten:
            return "10"
        case .twenty:
            return "20"
        case .all:
            return "All"
        }
    }
}
