//
//  CategoryDBHelper.swift
//  Pick&PayStore
//
//  Created by Owner on 2022-07-07.
//

import Foundation
import UIKit
import CoreData

class CategoryDBHelper
{
    static var categoryDBHelper = CategoryDBHelper()
    
    let context  = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addCategory(name: String , image: String, id: Int64)
    {
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context!) as! Category
        
        category.name = name
        category.image = image
        category.id = Int64(id)
        category.products = []
        
        
        do{
            try context?.save()
            print("category added to the core data")
        } catch{
            print("error adding category")
        }
        
    }
    
    func getCategories() ->[Category]
    {
        var categories = [Category]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        do{
            categories = try context?.fetch(fetchRequest) as! [Category]
 
        } catch{
            print("error getting category")
        }
        
        
        return categories
    }
    
    func getCategory(id : Int64) -> Category {

            var category =  Category()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))

            do {
                let fetchedCategory =  try context?.fetch(fetchRequest)
                if fetchedCategory?.count != 0 {
                    category = fetchedCategory?.first as! Category
                }
            } catch {
                print("error getting category")
            }

            return category
        }
    
    
    func addProductToCategory(categoryId : Int, productId : Int) {

            var category =  Category()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(categoryId))

            do {
                let fetchedCategory =  try context?.fetch(fetchRequest)
                if fetchedCategory?.count != 0 {
                    category = fetchedCategory?.first as! Category
                    category.products?.append(NSNumber(value: productId))
                    try context?.save()
                    print("product added to category")
                }
            } catch {
                print("error getting category")
            }

        }
    
    func resetCategories(){
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")

            do {
                let categories = try context?.fetch(fetchRequest)
                if categories?.count != 0 {
                    for category in categories! {
                        context?.delete(category as! Category)
                    }
                    try context?.save()
                    print("categories reset")
                }
            } catch {
                print("error in resetting categories")
            }
        }
}
