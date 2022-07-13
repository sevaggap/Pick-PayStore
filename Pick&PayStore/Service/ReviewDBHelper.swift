//
//  ReviewDBHelper.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-12.
//

import Foundation
import CoreData
import UIKit

class ReviewDBHelper {
    
    static var reviewDBHelper =  ReviewDBHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addReview(text : String, productID : Int) {
        
        var review = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context!) as! Review
        
        review.text = text
        review.id = Int64(Int.random(in: 1...999))
        review.date = Date()
        review.productId = Int64(productID)
        
        do {
            try context?.save()
            print("review added")
        }  catch {
            print("error adding review")
        }
        
        var product = Product()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(productID))
        
        do{
            let fetchedProduct = try context?.fetch(fetchRequest)
            if fetchedProduct?.count != 0 {
                product = fetchedProduct?.first as! Product
                print(product.reviews)
                product.reviews?.append(NSNumber(value: review.id))
                print(product.reviews)
                try context?.save()
                print("review added to category")
            }
            
        } catch{
            print("error adding review to product")
        }
    }
    
    func getReview(id : Int64) -> Review{
        
        var review = Review()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Review")
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        
        do {
            let fetchedReview = try context?.fetch(fetchRequest)
            if fetchedReview?.count != 0 {
                review = fetchedReview?.first as! Review
            }
        } catch {
            print("error getting review")
        }
        
        return review
        
    }
    
    func resetReviews() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Review")
        
        do {
            let reviews = try context?.fetch(fetchRequest)
            if reviews?.count != 0 {
                for review in reviews! {
                    context?.delete(review as! Review)
                }
                try context?.save()
                print("reviews reset")
            }
        } catch {
            print("error in resetting reviews")
        }
    }
    
}
