//
//  Review+CoreDataProperties.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-13.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: Int64
    @NSManaged public var productId: Int64
    @NSManaged public var text: String?

}

extension Review : Identifiable {

}
