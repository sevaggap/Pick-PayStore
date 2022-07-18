//
//  TenderTypeService.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import Foundation

class TenderTypeService {
    static let service = TenderTypeService()
    var tenderTypes: [TenderType] = []
    
    func loadTenderTypes() {
        
        if TenderTypeService.service.tenderTypes.count != 0 {
            TenderTypeService.service.tenderTypes.removeAll()
        }
        
        TenderTypeService.service.tenderTypes.append(
            TenderType.init(tenderTypeCode: 0, tenderTypeDesc: "Cash on Delivery", tenderTypeImage: "TenderType-CoD", tenderTypeAmountLimit: 200)
        )
        TenderTypeService.service.tenderTypes.append(
            TenderType.init(tenderTypeCode: 1, tenderTypeDesc: "Credit/Debit Card", tenderTypeImage: "creditcard", tenderTypeAmountLimit: 0)
        )
        TenderTypeService.service.tenderTypes.append(
            TenderType.init(tenderTypeCode: 2, tenderTypeDesc: "Apple Pay", tenderTypeImage: "TenderType-ApplePay", tenderTypeAmountLimit: 0)
        )
    }
}
