//
//  TenderTypeViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/18/22.
//

import UIKit

class TenderTypeViewController: UIViewController {
    
    
    //VARIABLES FOR TENDER TYPE MODELS
    var tenderTypes: [TenderType] = []
    static let notification = Notification.Name("updateTenderType")
    static let vc = TenderTypeViewController()
    var cartSubtotal: Float?

    //MARK: PART 1 - PREPARE TENDER TYPE MODEL
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TenderTypeService.service.loadTenderTypes()
        tenderTypes = TenderTypeService.service.tenderTypes
        
        guard TenderTypeViewController.vc.cartSubtotal == nil else {
            if TenderTypeViewController.vc.cartSubtotal! > 200 {
                for tenderType in tenderTypes {
                    tenderTypes.removeAll(where: {(tenderType) -> Bool in
                        return tenderType.tenderTypeCode == 0
                    })
                }
            }
            return
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK: PART 2 - CONFIGURE TABLE VIEW DATASOURCE
extension TenderTypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tenderTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTenderType", for: indexPath) as! TenderTypeTableViewCell
        cell.selectionStyle = .none
        let model = tenderTypes[indexPath.row]
        let viewModel: TenderTypeViewModel = TenderTypeViewModel.init(tenderTypeCode: model.tenderTypeCode, tenderTypeDesc: model.tenderTypeDesc, tenderTypeImage: model.tenderTypeImage, tenderTypeAmountLimit: model.tenderTypeAmountLimit)
        cell.configure(viewModel: viewModel)
        return cell
    }
}
