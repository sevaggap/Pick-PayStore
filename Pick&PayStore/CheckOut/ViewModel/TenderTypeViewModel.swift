//
//  TenderTypeViewModel.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import Foundation


struct TenderTypeViewModel {
    var tenderTypeCode: Int
    var tenderTypeDesc: String
    var tenderTypeImage: String
    var isImageSytemImage: Bool
    var tenderTypeAmountLimit: Float
    
    init(
        tenderTypeCode: Int,
        tenderTypeDesc: String,
        tenderTypeImage: String,
        tenderTypeAmountLimit: Float
    ) {
        self.tenderTypeCode = tenderTypeCode
        self.tenderTypeDesc = tenderTypeDesc
        self.tenderTypeImage = tenderTypeImage
        self.tenderTypeAmountLimit = tenderTypeAmountLimit
        switch tenderTypeCode {
        case 1: self.isImageSytemImage = true
        default:
            self.isImageSytemImage = false
            print("Switch is exhaustive")
        }
    }
}
