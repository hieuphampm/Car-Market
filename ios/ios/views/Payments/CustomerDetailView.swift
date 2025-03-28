//
//  CustomerDetailView.swift
//  ios
//
//  Created by umtlab03im13 on 28/3/25.
//

import SwiftUI
import FirebaseFirestore

struct CustomerDetailView: View {
    let car: Car
    @State private var name: String = ""
    @State private var mobilePhone: String = ""
    @State private var email: String = ""
    @State private var address: String = ""
    @State private var showPaymentView: Bool = false
    
    private let db = Firestore.firestore()
    
    var body: some View {
        Form {
            Section(header: Text("Customer Information")) {
                TextField("Full Name", text: $name)
                    .textContentType(.name)
                TextField("Mobile Phone", text: $mobilePhone)
                    .keyboardType(.phonePad)
                TextField("Email (Optional)", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                TextField("Address (Optional)", text: $address)
                    .textContentType(.streetAddressLine1)
            }
            
            Button(action: saveCustomerAndProceed) {
                Text("Continue to Payment")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(name.isEmpty || mobilePhone.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(name.isEmpty || mobilePhone.isEmpty)
            
            // Use NavigationLink instead of navigationDestination
            NavigationLink(destination: PaymentView(car: car, customerId: generateCustomerId()), isActive: $showPaymentView) {
                EmptyView()
            }
        }
        .navigationTitle("Customer Details")
    }
    
    private func saveCustomerAndProceed() {
        let customerId = generateCustomerId()
        let customer = Customer(
            id: customerId,
            name: name,
            mobilePhone: mobilePhone,
            email: email.isEmpty ? nil : email,
            address: address.isEmpty ? nil : address
        )
        
        do {
            try db.collection("customers").document(customerId).setData(from: customer) { error in
                if let error = error {
                    print("Error saving customer: \(error)")
                } else {
                    showPaymentView = true
                }
            }
        } catch {
            print("Error encoding customer: \(error)")
        }
    }
    
    private func generateCustomerId() -> String {
        return "cust_\(UUID().uuidString)"
    }
}

#Preview {
    NavigationView {
        CustomerDetailView(car: Car(id: "car_01",
                                    name: "Porsche 911 GT3",
                                    price: 189000,
                                    engine: "4.0L Flat-6",
                                    year: 2022,
                                    transmission: "Manual",
                                    utilities: ["Ceramic Brakes"],
                                    mileage: 4600,
                                    imageURL: "https://via.placeholder.com/250"))
    }
}
