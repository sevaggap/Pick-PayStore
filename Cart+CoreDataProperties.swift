//
//  Cart+CoreDataProperties.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-06-30.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var lastUpdated: Date?
    @NSManaged public var items: [NSNumber]?

}

extension Cart : Identifiable {

}
