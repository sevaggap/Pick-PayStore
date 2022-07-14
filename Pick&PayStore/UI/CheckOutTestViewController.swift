//
//  ProductTestViewController.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-12.
//

import UIKit

class CheckOutTestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shoppingCart = Cart()
    var items = [Product]()
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    override func viewWillAppear(_ animated: Bool) {
        items = []
        shoppingCart = CartService.cartServiceInstance.getCart()
        for id in shoppingCart.items! {
            var product = ProductsHelper.productsHelper.getProduct(id: Int64(id))
            items.append(product)
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CheckOutTableViewCell
        
        cell.name.text = items[indexPath.row].name
        cell.imageName.image = UIImage(named: items[indexPath.row].image!)
        cell.quantity.text = String(Int(shoppingCart.quantity![indexPath.row]))
        return cell
    }

}
