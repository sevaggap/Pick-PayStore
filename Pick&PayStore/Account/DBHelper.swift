//
//  DBHelper.swift
//  P3SignUpLogin
//
//  Created by MAC on 2022-07-06.
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
        Users.firstName = first_Name
        Users.lastName = last_Name
        Users.email = e_email
        Users.password = p_password
        Users.verifyPassword = v_verifyPassword
        Users.userID = Int64(SharedServices.service.currentDate_FormattedForDB())!
        
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
    
    func getData(email: String) -> User? {
        var user: User?
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.fetchLimit = 1
        
        do {
            let request = try context?.fetch(fetchRequest) as! [User]
            if request.count != 0 {
                user = request.first as! User
            } else {
                print("Core Data: No user found.")
            }
        } catch {
            print("Core Data Error: Cannot fetch data.")
        }
        
        return user
    }
}

/*
 func getOne(name : String) -> Student { //get one student with name
     var student = Student()
     var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
     fetchRequest.predicate = NSPredicate(format: "name == %@", name)
     fetchRequest.fetchLimit = 1 //to fetch only the first item with the parameter "name"
     do {
         let request = try context?.fetch(fetchRequest) as! [Student]
         if request.count != 0 {
             student = request.first as! Student
         } else {
             print("Error: No student found.")
         }
     } catch {
         print("Error.")
     }
     return student
 }
 */
