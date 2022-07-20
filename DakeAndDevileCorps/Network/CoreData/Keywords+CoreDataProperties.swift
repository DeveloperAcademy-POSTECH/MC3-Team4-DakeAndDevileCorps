//
//  Keywords+CoreDataProperties.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import CoreData
import Foundation

extension Keywords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Keywords> {
        return NSFetchRequest<Keywords>(entityName: "Keywords")
    }

    @NSManaged public var term: String
}
