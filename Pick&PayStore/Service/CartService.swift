//
//  CartService.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-12.
//

import Foundation

class CartService {
    
    static var cartServiceInstance = CartService()
    
    func createCart() {
        CartDBHelper.cartDBHelper.createCart()
    }
    
    func addUpdateItemToCart(itemId : Int64, quantity : Int) {
        CartDBHelper.cartDBHelper.addUpdateItemToCart(itemId: itemId, quantity: quantity)
    }
    
    func getCart() -> Cart {
        return CartDBHelper.cartDBHelper.getCart()
    }

    func resetCart() {
        CartDBHelper.cartDBHelper.resetCart()
    }
    
    func removeItemFromCart(itemId : Int64){
        CartDBHelper.cartDBHelper.removeItemFromCart(itemId: itemId)
    }
    
}
