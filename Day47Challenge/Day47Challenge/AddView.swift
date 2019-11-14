//
//  AddView.swift
//  Day47Challenge
//
//  Created by John Mueller on 11/9/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model: ActivitiesModel
    
    @State private var nameText: String = ""
    @State private var descriptionText: String = ""
    @State private var targetInterval = 1
    
    private var allActivityNames = Set<String>()
    
    init(model: ActivitiesModel) {
        self.model = model
        allActivityNames = Set(model.activities.map { $0.name })
    }
    
    var buttonDisabled: Bool {
        nameText.trimmingCharacters(in: .whitespaces).isEmpty ||
            descriptionText.trimmingCharacters(in: .whitespaces).isEmpty ||
            allActivityNames.contains(nameText.trimmingCharacters(in: .whitespaces))
    }
    
    var body: some View {
        Form {
            Section(header:
                HStack {
                    Text("Add new activity")
                        .font(.title)
                    
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
                .padding(.vertical)
            ) {
                TextField("Name", text: $nameText)
                TextField("Description", text: $descriptionText)
            }
            
            Section {
                Stepper(Activity.intervalString(from: targetInterval), value: $targetInterval, in: 1...7)
            }
            
            Section {
                Button("Add Activity") {
                    let newActivity = Activity(name: self.nameText,
                                               description: self.descriptionText,
                                               targetInterval: self.targetInterval,
                                               completions: [])
                    self.model.activities.append(newActivity)
                    self.model.activities.sort()
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(buttonDisabled)
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(model: ActivitiesModel())
    }
}
