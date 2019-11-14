//
//  StatusTag.swift
//  Day47Challenge
//
//  Created by John Mueller on 11/14/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct StatusTag: View {
    var status: Activity.Status

    private var color: Color {
        switch status {
        case .current:
            return .green
        case .due:
            return .yellow
        case .overdue:
            return .red
        }
    }

    private var text: String {
        switch status {
        case .current:
            return "Complete"
        case .due:
            return "Due"
        case .overdue:
            return "Overdue"
        }
    }

    var body: some View {
        ZStack {
            Text("Complete")
                .opacity(0)
                .padding(10)
                .background(Capsule().fill(color))
            Text(text)
        }
    }
}

struct StatusTag_Previews: PreviewProvider {
    static var previews: some View {
        StatusTag(status: .current)
    }
}
