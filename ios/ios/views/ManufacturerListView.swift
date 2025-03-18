//
//  ManufacturerListView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct ManufacturerListView: View {
    @State private var manufacturers = [
        "Toyota", "Ford", "BMW", "Tesla", "Honda"
    ]
    
    var body: some View {
        List(manufacturers, id: \.self) { manufacturer in
            NavigationLink(destination: ManufacturerDetailView(manufacturer: manufacturer)) {
                Text(manufacturer)
            }
        }
        .navigationTitle("Manufacturers")
    }
}

#Preview {
    ManufacturerListView()
}
