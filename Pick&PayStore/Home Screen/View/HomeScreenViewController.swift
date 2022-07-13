//
//  HomeScreenViewController.swift
//  Pick&PayStore
//
//  Created by Owner on 2022-07-07.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var categoryData = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryService.categoryServiceInstance.resetData()
        CategoryService.categoryServiceInstance.addCategoryData()
        CategoryService.categoryServiceInstance.addProductsToCategories()
        categoryData = CategoryService.categoryServiceInstance.getData()
       
        ProductsService.productsServiceInstance.resetData()
        ProductsService.productsServiceInstance.addData()
        
        ReviewService.reviewServiceInstance.addReview(text: "this is a test review", productID: 1)
//        CartService.cartServiceInstance.resetCart()
//        CartService.cartServiceInstance.createCart()
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 3, quantity: 5)
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 3, quantity: 5)
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 3, quantity: 5)
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 1, quantity: 5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITestViewController.productIds = []
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! CategoryCollectionViewCell
        let model = categoryData[indexPath.row]
        let viewModel = HomeCategoryViewModel(id: model.id, name:model.name!, image: model.image!)
        cell.configure(with: viewModel)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = categoryData[indexPath.row].id
        let category = CategoryDBHelper.categoryDBHelper.getCategory(id: id)
        print("this is the category",category.products)
        
//        let storyboard = UIStoryboard(name:"Products", bundle:nil)
//        let productScreen = storyboard.instantiateViewController(withIdentifier: "productsVC") as! UITestViewController
        UITestViewController.productIds = category.products!
//        navigationController?.pushViewController(productScreen,animated: true)
        
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![3]
                                                 
    }
}
