//
//  AddCarView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct AddCarView: View {
    @State private var modelName = ""
    @State private var price = ""
    @State private var year = ""
    @State private var mileage = ""
    
    var body: some View {
        Form {
            Section(header: Text("Car Information")) {
                TextField("Model Name", text: $modelName)
                TextField("Price", text: $price)
                    .keyboardType(.decimalPad)
                TextField("Year", text: $year)
                    .keyboardType(.numberPad)
                TextField("Mileage", text: $mileage)
                    .keyboardType(.numberPad)
            }
            
            Button("Add Car") {
                // Gọi API hoặc lưu vào database
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .navigationTitle("Add New Car")
    }
}


#Preview {
    AddCarView()
}
