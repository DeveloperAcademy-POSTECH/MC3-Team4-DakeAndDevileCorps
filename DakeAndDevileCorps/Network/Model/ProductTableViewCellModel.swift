//
//  ProductTableViewCellModel.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/27.
//

import Foundation

enum ProductTableViewCellModel: Equatable {
    case product(productName: String)
    case item(itemName: String, itemPrice: String)
}
