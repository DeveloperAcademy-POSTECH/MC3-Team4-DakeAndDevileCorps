//
//  ReviewModel.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/27.
//

import Foundation

struct ReviewModel {
    var reviewTitle: String
    var reviewContent: String
    var category: String
    var nickname: String
    var reviewDate: String
    var reviewImageNames: [String]

    init(reviewTitle: String = "",
         reviewContent: String = "",
         category: String = "",
         nickname: String = "",
         reviewDate: String = "",
         reviewImageNames: [String] = []) {
        self.reviewTitle = reviewTitle
        self.reviewContent = reviewContent
        self.category = category
        self.nickname = nickname
        self.reviewDate = reviewDate
        self.reviewImageNames = reviewImageNames
    }
}
