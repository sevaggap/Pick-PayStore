//
//  ProductsHelper.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-03.
//

import Foundation
import UIKit
import CoreData

class ProductsHelper{
    static var productsHelper = ProductsHelper()
    
    let context  = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addProduct(name : String, price : Float, quantity : Int64, category : Int64, image : String){
        
        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context!) as! Product
        
        product.name = name
        product.price = price
        product.quantity = quantity
        product.category = category
        product.image = image
        product.id = Int64.random(in: 1...999)
        product.reviews = nil
        
        do {
            try context?.save()
            print("product added to core data")
        } catch {
            print("error in adding product to core  data")
        }

     }
    
    func getProducts() -> [Product]{
        
        var products = [Product]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        do {
            products = try context?.fetch(fetchRequest) as! [Product]
        } catch {
            print("error in getting products")
        }
        
        return products
        
    }
    
    func resetProdcuts(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        do {
            let products = try context?.fetch(fetchRequest)
            if products?.count != 0 {
                for product in products! {
                    context?.delete(product as! Product)
                }
                try context?.save()
                print("products reset")
            }
        } catch {
            print("error in resetting products")
        }
    }
    
}


