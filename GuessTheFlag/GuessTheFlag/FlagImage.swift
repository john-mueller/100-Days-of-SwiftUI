//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by John Mueller on 10/15/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var name: String

    init(_ name: String) {
        self.name = name
    }

    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage("US")
    }
}
