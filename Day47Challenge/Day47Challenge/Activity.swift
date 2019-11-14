//
//  Activity.swift
//  Day47Challenge
//
//  Created by John Mueller on 11/9/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import Foundation

import SwiftUI

struct Activity: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var targetInterval: Int = 1
    var completions = [Date]()

    var averageInterval: Int? {
        guard completions.count > 1 else { return nil }
        let seconds = (0 ..< completions.count - 1).map { index in
            completions[index].distance(to: completions[index + 1])
        }.average()
        return Int(seconds / 86400)
    }

    static func intervalString(from interval: Int?) -> String {
        guard let interval = interval else { return "N/A" }
        switch interval {
        case let days where days <= 1:
            return "Every day"
        case let days where days == 7:
            return "Every week"
        default:
            return "Every \(interval) days"
        }
    }

    var status: Status {
        guard let last = completions.last else { return .due }

        let calendar = Calendar.current
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfLast = calendar.startOfDay(for: last)
        let components = calendar.dateComponents([.day], from: startOfLast, to: startOfNow)

        guard let days = components.day else { return .due }

        switch days {
        case let days where days <= targetInterval:
            return .current
        case let days where days - 1 <= targetInterval:
            return .due
        default:
            return .overdue
        }
    }

    enum Status {
        case current, due, overdue
    }
}

extension Activity: Comparable {
    static func < (lhs: Activity, rhs: Activity) -> Bool {
        lhs.name < rhs.name
    }
}

extension Array where Element == Double {
    func average() -> Double {
        self.reduce(0, +) / Double(self.count)
    }
}
