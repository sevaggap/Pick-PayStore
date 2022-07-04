//
//  UITestViewController.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-03.
//

import UIKit

class UITestViewController: UIViewController {
    
    var productData = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ProductsService.productsServiceInstance.resetData()
        ProductsService.productsServiceInstance.addData()
        productData = ProductsService.productsServiceInstance.getData()
    }

}

extension UITestViewController : UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITestTableViewCell
        
        let model = productData[indexPath.row]
        let viewModel = TestProductsViewModel(name: model.name!, price: model.price, image: model.image!)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    
    
}
