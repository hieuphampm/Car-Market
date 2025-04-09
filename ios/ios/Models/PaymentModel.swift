//
//  PaymentModel.swift
//  ios
//
//  Created by umtlab03im13 on 28/3/25.
//

import Foundation

struct Payment: Identifiable, Codable {
    let id: String
    let customerId: String
    let carId: String
    let amount: Double
    let method: String
    let timestamp: Date
}
