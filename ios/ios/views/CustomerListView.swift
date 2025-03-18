//
//  CustomerListView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct CustomerListView: View {
    @State private var customers = [
        "John Doe", "Alice Smith", "Michael Johnson"
    ]
    
    var body: some View {
        List(customers, id: \.self) { customer in
            NavigationLink(destination: CustomerDetailView(customer: customer)) {
                Text(customer)
            }
        }
        .navigationTitle("Customers")
    }
}


#Preview {
    CustomerListView()
}
