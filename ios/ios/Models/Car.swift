//
//  Car.swift
//  ios
//
//  Created by umtlab03im13 on 25/3/25.
//

import Foundation

struct Car: Identifiable, Codable {
    var id: String
    let name: String
    let price: Double
    let engine: String
    let year: Int
    let transmission: String
    let utilities: [String]
    let mileage: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case engine
        case year
        case transmission
        case utilities
        case mileage
        case imageURL
    }
}
