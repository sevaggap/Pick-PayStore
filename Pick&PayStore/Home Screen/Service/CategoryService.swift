//
//  CategoryService.swift
//  Pick&PayStore
//
//  Created by Owner on 2022-07-07.
//

import Foundation
class CategoryService{

static var categoryServiceInstance = CategoryService()
    
    func resetData() {
        CategoryDBHelper.categoryDBHelper.resetCategories()
    }
    
    func addCategoryData() {
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Electronics", image: "electronics", id: 1)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "TV & Appliances", image: "tv-appliances", id: 2)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Womens Fashion", image: "women-clothes", id: 3)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Mens Fashion", image: "men-clothes", id: 4)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Sports and fitness", image: "sports-fitness", id: 5)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Health and Beauty ", image: "health-beauty", id: 6)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Footwear", image: "footwear", id: 7)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Travel", image: "travel", id: 8)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Kitchen", image: "kitchen", id: 9)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Furniture", image: "furniture", id: 10)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Gardening & Outdoors", image: "gardening-outdoors", id: 11)
    CategoryDBHelper.categoryDBHelper.addCategory(name: "Books", image: "books", id: 12)
    }
    
    func addProductsToCategories(){
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 1, productId: 1)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 1, productId: 2)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 1, productId: 3)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 1, productId: 4)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 1, productId: 5)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 2, productId: 6)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 2, productId: 7)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 2, productId: 8)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 2, productId: 9)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 2, productId: 10)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 3, productId: 11)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 3, productId: 12)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 3, productId: 13)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 3, productId: 14)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 3, productId: 15)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 4, productId: 16)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 4, productId: 17)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 4, productId: 18)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 4, productId: 19)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 4, productId: 20)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 5, productId: 21)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 5, productId: 22)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 5, productId: 23)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 5, productId: 24)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 5, productId: 25)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 6, productId: 26)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 6, productId: 27)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 6, productId: 28)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 6, productId: 29)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 6, productId: 30)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 7, productId: 31)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 7, productId: 32)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 7, productId: 33)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 7, productId: 34)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 7, productId: 35)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 8, productId: 36)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 8, productId: 37)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 8, productId: 38)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 8, productId: 39)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 8, productId: 40)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 9, productId: 41)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 9, productId: 42)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 9, productId: 43)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 9, productId: 44)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 9, productId: 45)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 10, productId: 46)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 10, productId: 47)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 10, productId: 48)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 10, productId: 49)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 10, productId: 50)

//        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 11, productId: 51)
//        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 11, productId: 52)
//        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 11, productId: 53)
//        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 11, productId: 54)
//        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 11, productId: 55)

        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 12, productId: 56)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 12, productId: 57)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 12, productId: 58)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 12, productId: 59)
        CategoryDBHelper.categoryDBHelper.addProductToCategory(categoryId: 12, productId: 60)

    }
    
    
    func getData()-> [Category]{
        let categories = CategoryDBHelper.categoryDBHelper.getCategories()
        
        return categories
    }
    
    func getSingleCategory(id : Int64) -> Category {
        let category = CategoryDBHelper.categoryDBHelper.getCategory(id: id)
        
        return category
    }
}
