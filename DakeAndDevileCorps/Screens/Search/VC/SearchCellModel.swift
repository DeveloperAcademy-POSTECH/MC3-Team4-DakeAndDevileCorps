//
//  SearchCellModel.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/20.
//

import UIKit

enum SearchCellModel {
    case recentSearch(title: String)
    case result(storeName: String, storeAddress: String, distance: CGFloat)
}
