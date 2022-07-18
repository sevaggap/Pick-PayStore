//
//  UserCartViewModel.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import Foundation


struct UserCartViewModel {
    var indexPathRowOfProduct: Int
    var productID: Int64
    var imageName: String
    var productDesc: String
    var productUnitPrice: Float
    var productStockQty: Int64
    var productCartQty: Int64
    var freeShipping: Bool
}

