//
//  CartBannerView_UIViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/15/22.
//

import UIKit

class CartBannerView_UIViewController: UIViewController {

    
    @IBOutlet weak var tableViewCartBanner: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewCartBanner.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CartBannerView_UIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartBannerCell = tableView.dequeueReusableCell(withIdentifier: "cartBannerCell", for: indexPath) as! CartBannerView_UITableViewCell
        //let productID = UITestViewController.vc.productAtRow
        let productID: Int64? = SingleProductViewController.vcForCartBanner.productIDForCartBanner
        cartBannerCell.selectionStyle = .none
        cartBannerCell.labelItemDesc.text = ProductsService.productsServiceInstance.getOneProduct(id: productID!).name
        //cartBannerCell.imageViewItemImg.tintColor = .white
        //cartBannerCell.imageViewItemImg.image = UIImage(systemName: "checkmark.circle.fill")
        return cartBannerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CheckOut", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "shoppingCartVC")
//        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        self.present(viewController, animated: true)
        //self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![2]
    }
    
    
}
