//
//  BankTransferView.swift
//  ios
//
//  Created by umtlab03im13 on 28/3/25.
//

import SwiftUI

struct BankTransferView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Bank Transfer")
                .font(.headline)
            
            Text("Scan QR Code to Complete Payment")
                .font(.subheadline)
            
            Image(systemName: "qrcode")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .foregroundColor(.blue)
                .overlay(
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 2)
                )
            
            Text("Account Details:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("Bank: Sample Bank")
                .font(.caption)
            Text("Account Number: 1234 5678 9012")
                .font(.caption)
            Text("IFSC: SAMPLE0001234")
                .font(.caption)
        }
        .padding()
    }
}
