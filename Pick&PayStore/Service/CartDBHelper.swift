//
//  CartDBHelper.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-12.
//

import Foundation
import CoreData
import UIKit

class CartDBHelper {
    
    static var cartDBHelper = CartDBHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func createCart(){
        
        let cart = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context!) as! Cart
        
        cart.items = []
        cart.quantity = []
        cart.lastUpdated = Date()
        
        
        do {
            try context?.save()
            print("cart created", cart.quantity)
        } catch {
            print("error creating cart")
        }
    }
    
    func getCart() -> Cart{
        
        var cart = Cart()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        
        do {
            let fetchedCart = try context?.fetch(fetchRequest)
            if fetchedCart?.count != 0 {
                cart = fetchedCart?.first as! Cart
            }
        } catch {
            print("error fethcing cart")
        }
        
        return cart
        
    }

    func addUpdateItemToCart(itemId : Int64, quantity : Int) {
        
        var cart = Cart()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        
        do {
            let fetchedCart = try context?.fetch(fetchRequest)
            if fetchedCart!.count != 0{
                cart = fetchedCart?.first as! Cart
                
                for i in 0..<cart.items!.count {
                    if cart.items![i] == NSNumber(value: itemId){
                        print(cart.quantity)
                        cart.quantity![i] = NSNumber(value : (Int(cart.quantity![i]) + quantity))
                        cart.lastUpdated = Date()
                        try context?.save()
                        print("item updated in cart")
                        return
                    }
                }
                
                cart.items?.append(NSNumber(value: itemId))
                cart.quantity?.append(NSNumber(value: quantity))
                try context?.save()
                print("item added to cart")
            
                
            }
        } catch {
            print("error saving item to cart")
        }
    
    }
    
    
    
    func removeItemFromCart(itemId : Int64) {
        var cart = Cart()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        
        do {
            let fetchedCart = try context?.fetch(fetchRequest)
            if fetchedCart!.count != 0 {
                cart = fetchedCart?.first as! Cart
                
                for i in 0..<cart.items!.count {
                    print(cart.items?.count)
                    if cart.items![i] == NSNumber(value: itemId){
                        cart.items?.remove(at: i)
                        cart.quantity?.remove(at: i)
                        try context?.save()
                        print("item removed from cart")
                        return
                    }
                    
                }
            }
            
        } catch {
            print("error in removing item from cart")
        }
    }
    
    func resetCarts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        
        do {
            let carts = try context?.fetch(fetchRequest)
            if carts?.count != 0 {
                for cart in carts! {
                    print(cart, "CARTS")
                    context?.delete(cart as! Cart)
                }
                try context?.save()
                print("carts deleted")
            }
            
        } catch {
            print("error resetting carts")
        }
    }
    
    func resetCart() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        
        do {
            let fetchedCart = try context?.fetch(fetchRequest)
            if fetchedCart!.count != 0 {
                var cart = fetchedCart?.first as! Cart
                cart.items?.removeAll()
                cart.quantity?.removeAll()
                try context?.save()
                print("cart reset")
            }
        } catch {
            print("error in resetting cart")
        }
    }
}
