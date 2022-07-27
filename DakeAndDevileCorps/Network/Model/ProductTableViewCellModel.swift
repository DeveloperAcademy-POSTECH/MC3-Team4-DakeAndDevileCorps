//
//  ProductTableViewCellModel.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/27.
//

import Foundation

enum ProductTableViewCellModel {
    case product(productName: String, isSeperated: Bool)
    case item(itemName: String, itemPrice: String)
}
