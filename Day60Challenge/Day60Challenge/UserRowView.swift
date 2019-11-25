//
//  UserRowView.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/21/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct UserRowView: View {
    @EnvironmentObject var model: UserListModel
    var user: User

    var body: some View {
        NavigationLink(destination: UserView(user: user)) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("blue"))

                ActiveIndicator(isActive: user.isActive)

                HStack(spacing: 10) {
                    Image("user-wide")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)

                        Text(user.company)
                    }

                    Spacer()
                }
                .padding(10)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: .dummyUser)
    }
}
