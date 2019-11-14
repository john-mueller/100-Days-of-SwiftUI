//
//  ActivityView.swift
//  Day47Challenge
//
//  Created by John Mueller on 11/11/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    @Binding var activity: Activity

    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack {
                    Text(activity.description)
                        .bold()
                    Spacer()
                }

                HStack {
                    HStack {
                        Text("Target: " + Activity.intervalString(from: activity.targetInterval))
                        Spacer()
                    }

                    HStack {
                        Text("Average: " + Activity.intervalString(from: activity.averageInterval))
                        Spacer()
                    }
                }

                HStack {
                    Text(completionString)
                    Spacer()
                }
            }
            .padding([.horizontal, .top])

            List {
                ForEach(activity.completions.reversed(), id: \.self) { date in
                    Text(self.formattedString(from: date))
                }
            }

            Spacer()
        }
        .navigationBarTitle(activity.name)
        .navigationBarItems(trailing: Button("Complete") {
            self.activity.completions.append(Date())
        })
    }

    var completionString: String {
        let count = activity.completions.count
        guard count > 0 else { return "Not completed yet" }
        return "Completed \(count) time\(count > 0 ? "s" : "")"
    }

    func formattedString(from date: Date) -> String {
        let formatter = DateFormatter()

        let calendar = Calendar.current
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfLast = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfLast, to: startOfNow)
        guard let days = components.day else { return "Unknown date" }

        let string: String
        if calendar.isDateInToday(date) {
            formatter.timeStyle = .short
            string = "Today, " + formatter.string(from: date)
        } else if days <= 7 {
            formatter.dateFormat = "EEEE, h:mm a"
            string = formatter.string(from: date)
        } else {
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            string = formatter.string(from: date)
        }

        return string
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: .constant(Activity(name: "Activity", description: "Description")))
    }
}
