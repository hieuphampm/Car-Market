//
//  CustomerDetailView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct CustomerDetailView: View {
    let customer: String
    
    var body: some View {
        VStack {
            Text(customer)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Email: johndoe@example.com")
            Text("Phone: +123456789")
        }
        .padding()
        .navigationTitle("Customer Details")
    }
}
