//
//  User+CoreDataProperties.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var verifyPassword: String?
    @NSManaged public var userID: Int64

}

extension User : Identifiable {

}
