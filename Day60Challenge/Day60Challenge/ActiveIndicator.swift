//
//  ActiveIndicator.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/22/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ActiveIndicator: View {
    var isActive: Bool

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Circle()
                    .fill(isActive ? Color("green") : Color("red"))
                    .frame(width: 20, height: 20)
                Spacer()
            }
            .padding([.trailing, .top], 10)
        }
    }
}

struct ActiveIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActiveIndicator(isActive: true)
    }
}
