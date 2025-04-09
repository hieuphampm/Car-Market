//
//  CardDetailsView.swift
//  ios
//
//  Created by umtlab03im13 on 28/3/25.
//

import SwiftUI

struct CardDetailsView: View {
    @Binding var cardNumber: String
    @Binding var cardHolderName: String
    @Binding var expiryDate: String
    @Binding var cvv: String
    var onSubmit: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Card Payment Details")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            VStack(alignment: .leading) {
                Text("Card Number")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("1234 5678 9012 3456", text: $cardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .autocapitalization(.none)
            }
            VStack(alignment: .leading) {
                Text("Cardholder Name")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("John Doe", text: $cardHolderName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.words)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Expiry Date")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("MM/YY", text: $expiryDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                }
                VStack(alignment: .leading) {
                    Text("CVV")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("123", text: $cvv)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
            }
            HStack {
                Image(systemName: "creditcard.fill")
                    .foregroundColor(.blue)
                Image(systemName: "creditcard")
                    .foregroundColor(.green)
                Image(systemName: "creditcard.and.123")
                    .foregroundColor(.red)
            }
            .padding(.top)
            Button("Submit Payment") {
                onSubmit()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
