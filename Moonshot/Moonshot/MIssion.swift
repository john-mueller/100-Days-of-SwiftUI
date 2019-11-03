//
//  MIssion.swift
//  Moonshot
//
//  Created by John Mueller on 11/2/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }

    var crewMemberString: String {
        let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

        let crewNames: [String] = crew.map { crewRole in
            guard let astronaut = astronauts.first(where: { $0.id == crewRole.name }) else {
                fatalError("Missing crew member")
            }

            return astronaut.name
        }

        return crewNames.joined(separator: "\n")
    }
}
