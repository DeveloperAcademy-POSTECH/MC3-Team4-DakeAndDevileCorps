//
//  Store.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/08/01.
//

import UIKit

// MARK: - StoreModel
struct StoreModel: Codable {
    let data: [Store]
}

struct Store: Codable {
    let name: String
    let latitude, longitude: Double
    let address, telephone: String
    let officeHour: [String]
    let items: [Item]
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case name
        case officeHour = "office_hour"
        case items
        case latitude
        case longitude
        case address, telephone
        case comments
    }
}
