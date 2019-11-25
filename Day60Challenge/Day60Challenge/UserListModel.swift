//
//  UserListModel.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/22/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import Foundation
import Combine

// TODO: sort and key on dictionary?
// TODO: CoreData?
class UserListModel: ObservableObject {
    //    var objectWillChange = PassthroughSubject<Void, Never>()
    @Published var users = [User]()
    @Published var loading = true

    init() {
        loadData()
    }

    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                if let decodedResponse = try? decoder.decode([User].self, from: data) {

                    DispatchQueue.main.async {
                        self.users = decodedResponse
                            .sorted { $0.name < $1.name }
                        self.loading = false
                    }

                    return
                }
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}
