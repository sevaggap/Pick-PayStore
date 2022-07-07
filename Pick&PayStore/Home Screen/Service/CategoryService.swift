//
//  CategoryService.swift
//  Pick&PayStore
//
//  Created by Owner on 2022-07-07.
//

import Foundation
class CategoryService{

static var categoryServiceInstance = CategoryService()
    
    func resetData()
    {
        CategoryDBHelper.categoryDBHelper.resetCategories()
    }
func addData()
{
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Electronics", image: "headphones", id: 1)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "TV & Appliances", image: "tv-appliances", id: 2)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Womens Fashion", image: "women-clothes", id: 3)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "mens Fashion", image: "men-clothes", id: 4)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Sports and fitness", image: "sports-fitness", id: 5)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Health and Beauty ", image: "health-beauty", id: 6)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Footwear ", image: "footwear", id: 7)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Travel ", image: "travel", id: 8)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "kitchen ", image: "kitchen", id: 9)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "furniture ", image: "furniture", id: 10)
    
    CategoryDBHelper.categoryDBHelper.addCategory(name: "books ", image: "books", id: 12)
    
    
    
}
    func addProductData(){
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId:1, productId: 1)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId:2, productId: 2)
    }
    
    
    func getData()-> [Category]{
    let categories = CategoryDBHelper.categoryDBHelper.getCategories()
    return categories

    
}
}
