//
//  UserView.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/21/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var model: UserListModel
    var user: User
    
//    @State private var layoutSize: CGSize = .zero
    @State private var aboutHeight: CGFloat = 0
//    @State private var tagsWidth: CGFloat = 0
    
    private var registered: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: user.registered)
    }

    private var address: (firstLine: String, secondLine: String) {
        let components = user.address.components(separatedBy: .punctuationCharacters)
        let index = components.count - 3
        let firstLine = components[0..<index].joined(separator: ",")
            .trimmingCharacters(in: .punctuationCharacters)
        let secondLine = components[index..<components.count].joined(separator: ",")
        return (firstLine, secondLine)
    }
    
    private var friends: [User] {
        user.friends.compactMap { friend in
            model.users.first(where: { user in
                user.id == friend.id
            })
        }
        .sorted { $0.name < $1.name }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    Spacer().frame(height: 0)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("blue"))
                        
                        ActiveIndicator(isActive: self.user.isActive)
                        
                        VStack(spacing: 10) {
                            VStack(spacing: 0) {
                                Text(self.user.name)
                                    .font(.largeTitle)
                                Text(self.user.company)
                                    .font(.headline)
                            }
                            
                            HStack(spacing: 10) {
                                Image("user-wide")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .onTapGesture {
                                        if let index = self.model.users.firstIndex(where: { $0.id == self.user.id }) {
                                            self.model.users[index].isActive.toggle()
                                        }
                                }
                                .padding(.leading, 3)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Status: \(self.user.isActive ? "Active" : "Inactive")")
                                    Text("Joined: \(self.registered)")
                                    Text("Age: \(self.user.age)")
                                }
                                
                                Spacer()
                            }
                            
                            Text(self.user.email)
                            
                            VStack(spacing: 0) {
                                Text(self.address.firstLine)
                                Text(self.address.secondLine)
                            }
                            
                            Text(self.user.about)
                                .frame(height: self.aboutHeight)
                        }
                        .padding(.horizontal, 10)
                        
                        AboutHeightReader(string: self.user.about, height: self.$aboutHeight)
                            .padding(.horizontal, 10)
                    }
                    
                    Section(header: Text("Tags")) {
                        TagsView(tags: self.user.tags, width: geometry.size.width * 0.7)
                    }
                    
                    Section(header: Text("Friends")) {
                        ForEach(self.friends) { friend in
                            UserRowView(user: friend)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .background(Color("gray").edgesIgnoringSafeArea([.bottom]))
        .navigationBarTitle("\(self.user.name)", displayMode: .inline)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: .dummyUser)
    }
}
