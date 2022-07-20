//
//  HomeScreenViewController.swift
//  Pick&PayStore
//
//  Created by Owner on 2022-07-07.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var welcomeMsg: UILabel!
    static var searchResults = [NSNumber]()
    
    var categoryData = [Category]()
    
    static var searchHistory = [SearchHistory]()
    
    @IBAction func buttonOrderHistory(_ sender: Any) {
        if LoginStatus.status.isLoggedIn {
            let storyborard = UIStoryboard(name: "CheckOut", bundle: nil)
            let vc = storyborard.instantiateViewController(withIdentifier: "orderHistoryVC")
            self.present(vc, animated: true)
        } else {
            let alertController = UIAlertController(title: "You're not signed in yet.", message: "Please sign in first to view your order history.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true)

        }
    }
    @IBOutlet weak var searchHistoryButton: UIButton!
    //@IBOutlet weak var bannerCollectionView: UICollectionView!
    //@IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var selectLocationButton: UIButton!
        
//    var bannerImage = [HomeBannerViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        CategoryService.categoryServiceInstance.resetData()
//        CategoryService.categoryServiceInstance.addCategoryData()
//        CategoryService.categoryServiceInstance.addProductsToCategories()
        categoryData = CategoryService.categoryServiceInstance.getData()
//
//        ProductsService.productsServiceInstance.resetData()
//        ProductsService.productsServiceInstance.addData()
        
//        ReviewService.reviewServiceInstance.addReview(text: "this is a test review", productID: 1)
//        CartDBHelper.cartDBHelper.resetCarts()
//        CartService.cartServiceInstance.resetCart()
//        CartService.cartServiceInstance.createCart()
//        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 3, quantity: 5)
//        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 3, quantity: 5)
//        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 3, quantity: 5)
//        CartService.cartServiceInstance.addUpdateItemToCart(itemId: 1, quantity: 5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITestViewController.productIds = []
        HomeScreenViewController.searchHistory = SearchHistoryDBHelper.searchHistoryDBHelper.getSearchHistory()
        configureWelcomeMsg()
    }
    
    
    @IBAction func searchHistoryButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let searchHistoryVC = storyboard.instantiateViewController(withIdentifier: "searchHistoryVC")
    
        self.present(searchHistoryVC, animated: true)
    }
    
    @IBAction func selectLocationButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![1]
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
        ProductListViewController.productIds = category.products!
        ProductListViewController.categoryId = id

        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![1]
    }
}

extension HomeScreenViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        HomeScreenViewController.searchResults.removeAll()
        var products : [Product] = ProductsService.productsServiceInstance.getData()
        
        for product in products{
            if product.name!.lowercased().contains(searchText.lowercased()) {
                HomeScreenViewController.searchResults.append(NSNumber(value: product.id))
            }
        }
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchHistoryDBHelper.searchHistoryDBHelper.addSearchTerm(name: searchBar.text!)
        ProductListViewController.productIds = HomeScreenViewController.searchResults
        ProductListViewController.categoryId = 0
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![1]
        
    }
    
    func configureWelcomeMsg() {
        if LoginStatus.status.isLoggedIn {
            let user: User = LoginStatus.status.currentUser!
            welcomeMsg.text = "\(user.firstName!)!"
        } else {
            welcomeMsg.text = "please sign in for better experience."
        }
    }
}



