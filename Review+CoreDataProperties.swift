//
//  Review+CoreDataProperties.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-06-30.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var id: Int64
    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var productId: Int64

}

extension Review : Identifiable {

}
