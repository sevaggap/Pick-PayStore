//
//  DBHelper.swift
//  Pick&PayStore
//
//  Created by MAC on 2022-07-15.
//

import Foundation
import CoreData
import UIKit

class DBHelper: NSManagedObject{
    
    static var dbHelper = DBHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //save Users to Core Data
    func saveData(first_Name: String, last_Name: String, e_email : String, p_password: String, v_verifyPassword: String){
        let Users = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        Users.fName = first_Name
        Users.lName = last_Name
        Users.email = e_email
        Users.password = p_password
//        Users.verifyPassword = v_verifyPassword
        
        do{
           try context?.save()
            print("User saved")
            
        }
        catch{
            print("error in saving User")
        }
    }
    
    func getData() -> [User]{
        var Users = [User]()
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            Users = try context?.fetch(fetchRequest) as! [User]
        }
        catch{
            print("cannot fetch data")
        }
        return Users
    }
}
