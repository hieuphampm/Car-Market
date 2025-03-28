//
//  CustomerModel.swift
//  ios
//
//  Created by umtlab03im13 on 28/3/25.
//

import Foundation

struct Customer: Identifiable, Codable {
    let id: String
    var name: String
    var mobilePhone: String
    var email: String?
    var address: String?
}
