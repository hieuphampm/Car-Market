//
//  ManufacturerDetailView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct ManufacturerDetailView: View {
    let manufacturer: String
    
    var body: some View {
        VStack {
            Text(manufacturer)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Country: Japan")
            Text("Founded: 1937")
            Text("Website: toyota.com")
        }
        .padding()
        .navigationTitle("Manufacturer Details")
    }
}
