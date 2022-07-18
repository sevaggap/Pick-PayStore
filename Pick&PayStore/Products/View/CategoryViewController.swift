//
//  CategoryViewController.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-14.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categoryData = [Category]()

    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ProductListViewController.productIds.isEmpty {
            categoryData = CategoryService.categoryServiceInstance.getData()
        } else {
            let storyboard = UIStoryboard(name: "Products", bundle: nil)
            let productsList = storyboard.instantiateViewController(withIdentifier: "productsListVC")

            navigationController?.pushViewController(productsList, animated: true)
        }
        collection.reloadData()
    }
}

extension CategoryViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! ProductCategoryCollectionViewCell
        
        let model = categoryData[indexPath.row]
        let viewModel = CategoryPageViewModel(name: model.name!, image: model.image!, id: model.id)
        
        cell.configure(viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = categoryData[indexPath.row].id
        let category = CategoryService.categoryServiceInstance.getSingleCategory(id: id)
        
        ProductListViewController.productIds = category.products!
        ProductListViewController.categoryId = id
        
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let productsList = storyboard.instantiateViewController(withIdentifier: "productsListVC")
        
        navigationController?.pushViewController(productsList, animated: true)
    }
    
    
    
    
}


