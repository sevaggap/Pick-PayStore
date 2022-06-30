//
//  Product+CoreDataProperties.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-06-30.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var quantity: Int64
    @NSManaged public var category: Int64
    @NSManaged public var image: String?
    @NSManaged public var id: Int64
    @NSManaged public var reviews: [Review]?

}

extension Product : Identifiable {

}
