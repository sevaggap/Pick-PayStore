//
//  ProductListViewController.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-14.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var categoryName: UILabel!
    
    static var productIds = [NSNumber]()
    static var categoryId = Int64()
    var productData = [Product]()
    var tempProductIds = [NSNumber]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !tempProductIds.isEmpty {
            ProductListViewController.productIds =  tempProductIds
            tempProductIds.removeAll()
        }
        
        productData = []
        
        for id in ProductListViewController.productIds{
            let product = ProductsService.productsServiceInstance.getOneProduct(id: Int64(id))
            productData.append(product)
        }
       
        if ProductListViewController.categoryId != 0{
            let category = CategoryService.categoryServiceInstance.getSingleCategory(id: ProductListViewController.categoryId)
            categoryName.text = category.name
        } else {
            categoryName.text = "Search Results"
        }
       
        for product in productData {
            print(product.quantity)
        }
                
        table.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tempProductIds = ProductListViewController.productIds
        ProductListViewController.productIds.removeAll()
    }

}

extension ProductListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsListCell", for: indexPath) as! ProductsListTableViewCell
        cell.selectionStyle = .none
        
        let model = productData[indexPath.row]
        let viewModel = ProductPageViewModel(name: model.name!, price: model.price, image: model.image!, quantity: model.quantity, id: model.id)
        
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productId = productData[indexPath.row].id
        
        SingleProductViewController.productId = productId
        
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let singleProductVC = storyboard.instantiateViewController(withIdentifier: "singleProductVC")
        
        navigationController?.pushViewController(singleProductVC, animated: true)
    }
    
    
}
