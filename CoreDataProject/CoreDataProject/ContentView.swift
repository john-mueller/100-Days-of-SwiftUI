//
//  ContentView.swift
//  CoreDataProject
//
//  Created by John Mueller on 11/20/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                ForEach(ViewType.allCases, id: \.self) { type in
                    NavigationLink("\(type.typeString)", destination:
                        self.getViewFor(type: type)
                            .navigationBarTitle("\(type.typeString)", displayMode: .inline)
                    )
                }
            }
            .navigationBarTitle("CoreDataProject")
        }
    }
}

extension ContentView {
    func getViewFor(type: ViewType) -> AnyView {
        switch type {
        case .wizard:
            return AnyView(WizardDemo())
        case .ship:
            return AnyView(ShipDemo())
        case .singer:
            return AnyView(SingerDemo())
        case .candy:
            return AnyView(CandyDemo())
        }
    }

    enum ViewType: String, CaseIterable {
        case wizard, ship, singer, candy

        var typeString: String {
            rawValue.prefix(1).uppercased() + rawValue.dropFirst() + " Demo"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
