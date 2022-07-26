//
//  NSObject+Extension.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
