//
//  User.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/21/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

extension User {
    static let dummyUser = User(
        id: UUID(),
        isActive: true,
        name: "John Doe",
        age: 25,
        company: "Apple",
        email: "john@apple.com",
        address: "One Infinite Loop, Cupertino, CA 95014",
        about: "John likes to program",
        registered: Date().addingTimeInterval(-2_592_000),
        tags: ["one", "two", "three"],
        friends: []
    )
}
