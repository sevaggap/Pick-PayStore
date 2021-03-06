//
//  Category+CoreDataProperties.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-13.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var products: [NSNumber]?

}

extension Category : Identifiable {

}
