//
//  ViewController.swift
//  PicknPayProducts
//
//  Created by Dhananjay H. Roy on 2022-06-30.
//

import UIKit

class ProductsVC: UIViewController {


    var productList = ProductService.productServiceInstance.getData()
    
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        //Testing
        
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
        let viewModel = ProductViewModel(itemNamePVM: model.itemNamePD, itemImagePVM: model.itemImagePD)
        cell.itemNameLabel.text = viewModel.itemNamePVM
        cell.itemImage.image = UIImage(named: viewModel.itemImagePVM)
        print(viewModel.itemNamePVM)
        print(viewModel.itemImagePVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let model = productList[indexPath.row]
        let viewModel = ProductViewModel(itemNamePVM: model.itemNamePD, itemImagePVM: model.itemImagePD)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        vc.itemList = viewModel.itemNamePVM
        self.present(vc, animated:  true, completion: nil)
        print(viewModel.itemNamePVM)
    }
    
    
}
