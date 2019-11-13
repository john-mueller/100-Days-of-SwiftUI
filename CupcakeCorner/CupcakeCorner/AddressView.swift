//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by John Mueller on 11/12/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var model: OrderModel
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $model.order.name)
                TextField("Street Address", text: $model.order.streetAddress)
                TextField("City", text: $model.order.city)
                TextField("Zip", text: $model.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(model: model)) {
                    Text("Check out")
                }
            }
            .disabled(model.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(model: OrderModel())
    }
}
