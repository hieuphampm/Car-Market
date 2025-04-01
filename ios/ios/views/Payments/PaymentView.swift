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
    
    // Environment variable to access presentation mode
    @Environment(\.presentationMode) var presentationMode
    
    private let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            VStack {
                // Header content
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
                }
                
                // Scrollable payment method content area
                ScrollView {
                    VStack {
                        if selectedMethod == "bank_transfer" {
                            BankTransferView()
                        } else if selectedMethod == "cash" {
                            VStack(spacing: 15) {
                                Image(systemName: "banknote")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.green)
                                
                                Text("Pay with Cash")
                                    .font(.headline)
                                
                                Text("Please bring the exact amount to our office")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                            .padding()
                        } else {
                            VStack(spacing: 15) {
                                Image(systemName: "creditcard.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 60)
                                    .foregroundColor(.blue)
                                
                                Text("Pay with Credit/Debit Card")
                                    .font(.headline)
                                
                                Text("Click 'Complete Payment' to enter your card details securely")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                            .padding()
                        }
                    }
                    .padding(.bottom, 80)
                }
                
                Spacer()
            }
            
            // Fixed Bottom Button
            VStack {
                Spacer()
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
                .background(Color.white.opacity(0.95))
                .shadow(radius: 5)
            }
        }
        .navigationTitle("Payment")
        .sheet(isPresented: $showCardDetailsPopup) {
            CardDetailsView(
                cardNumber: $cardNumber,
                cardHolderName: $cardHolderName,
                expiryDate: $expiryDate,
                cvv: $cvv,
                onSubmit: {
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
                    
                    // Dismiss PaymentView
                    presentationMode.wrappedValue.dismiss()
                    
                    // Post notification to dismiss all views back to HomeView
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        NotificationCenter.default.post(name: Notification.Name("DismissToHomeView"), object: nil)
                    }
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
