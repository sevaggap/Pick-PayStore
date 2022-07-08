//
//  ProductsVC.swift
//  Pick&PayStore
//
//  Created by Dhananjay H. Roy on 2022-07-08.
//

import UIKit

class ProductsVC: UIViewController {


    var productList = [Category]()
    
    
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        productList = CategoryService.categoryServiceInstance.getData()
        
    }
   
    
    private func configureSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false   //it wont allow the phone back light to go dim during search
        searchController.searchBar.enablesReturnKeyAutomatically = false //to remove search button from keyboard to done
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        //prevents hinding searchbar during scrolling result
        definesPresentationContext = true
        //to display search bar properly
        searchController.searchBar.placeholder = "Search Product By Name"
    }
    
   
}

extension ProductsVC: UISearchResultsUpdating, UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
    }
}

extension ProductsVC: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pCell", for: indexPath) as! ProductCVC
        let model = productList[indexPath.row]
        print(productList[indexPath.row].id)
        let viewModel = HomeCategoryViewModel(id: model.id, name: model.name!, image: model.image!)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let id = productList[indexPath.row].id
        let category = CategoryDBHelper.categoryDBHelper.getCategory(id: id)
        print("this is the category",category.products)
        
        let storyboard = UIStoryboard(name:"Products", bundle:nil)
        let productScreen = storyboard.instantiateViewController(withIdentifier: "productsVC") as! UITestViewController
        productScreen.productIds = category.products!
    }
    
    
}

