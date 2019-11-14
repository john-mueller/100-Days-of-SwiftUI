//
//  ActivitiesModel.swift
//  Day47Challenge
//
//  Created by John Mueller on 11/9/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import Foundation

class ActivitiesModel: ObservableObject {
    @Published var activities = [
        Activity(name: "Guitar",
                 description: "Practice guitar for 30 minutes",
                 completions: [
                    Date().advanced(by: -86400 * 1.5),
                    Date().advanced(by: -86400)
            ]
        ),
        Activity(name: "Piano",
                 description: "Practice piano for 30 minutes",
                 completions: [
                    Date().advanced(by: -86400 * 3.5),
                    Date().advanced(by: -86400 * 2)
            ]
        ),
        Activity(name: "Tambourine",
                 description: "Practice tambourine for 30 minutes",
                 targetInterval: 2,
                 completions: [
                    Date().advanced(by: -86400 * 5.5),
                    Date().advanced(by: -86400 * 3)
            ]
        ),
        Activity(name: "Theremin",
                 description: "Practice theremin for 30 minutes",
                 targetInterval: 2,
                 completions: [
                    Date().advanced(by: -86400 * 14.5),
                    Date().advanced(by: -86400 * 7.5),
                    Date().advanced(by: -86400 * 4)
            ]
        )
    ]
    
}
