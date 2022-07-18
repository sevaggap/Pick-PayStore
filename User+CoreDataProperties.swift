//
//  User+CoreDataProperties.swift
//  Pick&PayStore
//
//  Created by MAC on 2022-07-15.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var fName: String?
    @NSManaged public var lName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: Int64

}

extension User : Identifiable {

}
