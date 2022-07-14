//
//  ReviewService.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-12.
//

import Foundation

class ReviewService {
    
    static var reviewServiceInstance = ReviewService()
    
    func addReview(text : String, productID : Int){
        ReviewDBHelper.reviewDBHelper.addReview(text: text, productID: productID)
    }
    
    func resetReview(){
        ReviewDBHelper.reviewDBHelper.resetReviews()
    }
    
    func getReview(reviewId : Int64) -> Review {
        let review = ReviewDBHelper.reviewDBHelper.getReview(reviewId: reviewId)
        
        return review
    }
    
}
