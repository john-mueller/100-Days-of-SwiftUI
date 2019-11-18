//
//  AddBookView.swift
//  Bookworm
//
//  Created by John Mueller on 11/15/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Unknown"
    @State private var review = ""

    let genres = ["Unknown", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)
                    TextField("Write a reivew", text: $review)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.hasValidInput(self.title, otherwise: "Unknown Book")
                        newBook.author = self.hasValidInput(self.author, otherwise: "Unknown Author")
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.hasValidInput(self.genre, otherwise: "Unknown")
                        newBook.review = self.hasValidInput(self.review, otherwise: "No review")
                        newBook.date = Date()

                        try? self.moc.save()

                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .navigationBarTitle("Add Book")
            }
        }
    }

    func hasValidInput(_ string: String, otherwise: String) -> String {
        let trimmed = string.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            return otherwise
        } else {
            return trimmed
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
