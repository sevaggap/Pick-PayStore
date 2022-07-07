//
//  ProductsService.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-03.
//

import Foundation

class ProductsService {
    
    static var productsServiceInstance = ProductsService()
    
    func resetData(){
        ProductsHelper.productsHelper.resetProdcuts()
    }
    
    func addData(){
        ProductsHelper.productsHelper.addProduct(name: "Toaster", price: 18.99, quantity: 10, category: 1, image: "online-shopping")
        ProductsHelper.productsHelper.addProduct(name: "Stove", price: 99.99, quantity: 1, category: 1, image: "open-box")
    }
    
    func getData() -> [Product]{
        
        let products = ProductsHelper.productsHelper.getProducts()
        
        return products
    }
}
