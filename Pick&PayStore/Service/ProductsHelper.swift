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
    
    func addProduct(name : String, price : Float, quantity : Int64, category : Int64, image : String, id: Int64){
        
        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context!) as! Product
        
        product.name = name
        product.price = price
        product.quantity = quantity
        product.category = category
        product.image = image
        product.id = id
       // product.id = Int64.random(in: 1...999)
        product.reviews = []
        
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
    
    func getProduct(id : Int64) -> Product {

            var product = Product()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))

            do {
                let fetchedCategory =  try context?.fetch(fetchRequest)
                if fetchedCategory?.count != 0 {
                    product = fetchedCategory?.first as! Product
                }
            } catch {
                print("error getting product")
            }

            return product
        }
    
    func getSearchedProducts(searchTerm : String) -> [Int64] {
        
        var product = Product()
        var productIds = [Int64]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "name == %@", searchTerm)
        
        print(searchTerm)
        do {
            let fetchedProducts = try context?.fetch(fetchRequest)
            print(fetchedProducts)
            if fetchedProducts?.count != 0 {
                for fetchedProduct in fetchedProducts! {
                    product = fetchedProduct as! Product
                    productIds.append(product.id)
                }
                print(productIds)
            }
        } catch {
            print("error searching for products")
        }

        return productIds
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
    
    func updateQuantity(id : Int64, amount : Int64) {
        var product = Product()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "id ==  %@", String(id))
        
        do {
            let fetchedProduct = try context?.fetch(fetchRequest)
            if fetchedProduct?.count != 0 {
                product = fetchedProduct?.first as! Product
                product.quantity = product.quantity - amount
                try context?.save()
                print("product stock updated")
            }
        } catch {
            print("error updating stock of product")
        }
    }
    
}


