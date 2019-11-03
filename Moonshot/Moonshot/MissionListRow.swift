//
//  MissionListRow.swift
//  Moonshot
//
//  Created by John Mueller on 11/3/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct MissionListRow: View {
    let mission: Mission
    let showingNames: Bool

    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)

            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                if showingNames {
                    Text(mission.crewMemberString)
                } else {
                    Text(mission.formattedLaunchDate)
                }
            }

            Spacer()
        }
    }
}

struct MissionListRow_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        MissionListRow(mission: missions[0], showingNames: false)
    }
}
