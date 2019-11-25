//
//  ContentView.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/21/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = UserListModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    Spacer().frame(height: 0)

                    if model.loading {
                        Text("Loading users...")
                        UserRowView(user: User.dummyUser)
                            .disabled(true)
                            .opacity(0)
                    }
                    
                    ForEach(model.users) { user in
                        UserRowView(user: user)
                    }
                }
            }
            .padding(.horizontal, 15)
            .background(Color("gray").edgesIgnoringSafeArea([.bottom]))
            .navigationBarTitle("Day60Challenge", displayMode: .inline)
            .environmentObject(model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
