//
//  PaymentView.swift
//  ios
//
//  Created by umtlab03im13 on 28/3/25.
//

import SwiftUI
import FirebaseFirestore

struct PaymentView: View {
    let car: Car
    let customerId: String
    @State private var selectedMethod: String = "card"
    @State private var isPaymentComplete: Bool = false
    
    // Card details
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    
    @State private var showCardDetailsPopup: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    private let db = Firestore.firestore()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(spacing: 20) {
                    Text("Payment for \(car.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Amount: $\(car.price, specifier: "%.2f")")
                        .font(.title3)
                        .foregroundColor(.blue)
                    
                    Picker("Payment Method", selection: $selectedMethod) {
                        Text("Credit/Debit Card").tag("card")
                        Text("Bank Transfer").tag("bank_transfer")
                        Text("Cash").tag("cash")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Conditional view based on payment method
                    if selectedMethod == "bank_transfer" {
                        BankTransferView()
                    }
                    
                    Spacer()
                }
                .padding()
                
                // Fixed Bottom Button
                Button(action: {
                    if selectedMethod == "card" {
                        showCardDetailsPopup = true
                    } else {
                        processPayment()
                    }
                }) {
                    Text("Complete Payment")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Payment")
            .sheet(isPresented: $showCardDetailsPopup) {
                CardDetailsView(
                    cardNumber: $cardNumber,
                    cardHolderName: $cardHolderName,
                    expiryDate: $expiryDate,
                    cvv: $cvv,
                    onSubmit: {
                        // Basic validation
                        if !cardNumber.isEmpty && !cardHolderName.isEmpty &&
                           !expiryDate.isEmpty && !cvv.isEmpty {
                            processPayment()
                            showCardDetailsPopup = false
                        }
                    }
                )
                .presentationDetents([.large])
            }
        }
    }
    
    private func processPayment() {
        let paymentId = "pay_\(UUID().uuidString)"
        let payment = Payment(
            id: paymentId,
            customerId: customerId,
            carId: car.id,
            amount: car.price,
            method: selectedMethod,
            timestamp: Date()
        )
        
        do {
            try db.collection("payments").document(paymentId).setData(from: payment) { error in
                if let error = error {
                    print("Error saving payment: \(error)")
                } else {
                    isPaymentComplete = true
                    // Navigate back to home view
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } catch {
            print("Error encoding payment: \(error)")
        }
    }
}

#Preview {
    PaymentView(car: Car(id: "car_01", name: "Porsche 911 GT3", price: 189000, engine: "4.0L Flat-6", year: 2022, transmission: "Manual", utilities: ["Ceramic Brakes"], mileage: 4600, imageURL: "https://via.placeholder.com/250"), customerId: "cust_test")
}
