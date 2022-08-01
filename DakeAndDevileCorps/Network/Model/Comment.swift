//
//  Comment.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/08/01.
//

import Foundation

struct Comment: Codable {
    let item: String
    let content: String
    let category: String
    let nickname: String
    let photo: [String]
    let date: String
}
