//
//  ContentView.swift
//  Day47Challenge
//
//  Created by John Mueller on 11/9/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ActivitiesModel()
    @State private var showingSheet = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var indexSet = IndexSet()

    var body: some View {
        NavigationView {
            List {
                ForEach(model.activities.indices, id: \.self) { index in
                    NavigationLink(destination: ActivityView(activity: self.$model.activities[index])) {
                        HStack {
                            Text(self.model.activities[index].name)
                            Spacer()
                            StatusTag(status: self.model.activities[index].status)
                        }
                    }
                }
                .onDelete { indexSet in
                    self.presentDeleteConfirmation(indexSet)
                }
            }
            .navigationBarTitle("Day47Challenge", displayMode: .inline)
            .navigationBarItems(trailing: makeButton())
            .sheet(isPresented: $showingSheet) { AddView(model: self.model) }
            .alert(isPresented: $showingAlert) { makeAlert() }
        }
    }

    func presentDeleteConfirmation(_ indexSet: IndexSet) {
        let name = indexSet.compactMap { model.activities[$0].name }.first ?? "this activity"
        self.alertMessage = "Are you sure you want to delete \(name)?"
        self.indexSet = indexSet
        self.showingAlert = true
    }

    func makeButton() -> some View {
        Button(action: {
            self.showingSheet = true
        }, label: {
            Image(systemName: "plus")
                .font(.title)
        })
    }

    func makeAlert() -> Alert {
        let confirmButton = Alert.Button.destructive(Text("Delete")) {
            withAnimation(.default) {
                self.model.activities.remove(atOffsets: self.indexSet)
            }
        }

        return Alert(title: Text("Please Confirm"),
                     message: Text(self.alertMessage),
                     primaryButton: confirmButton,
                     secondaryButton: .cancel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
