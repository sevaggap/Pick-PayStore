//
//  ViewController.swift
//  PicknPayProducts
//
//  Created by Dhananjay H. Roy on 2022-06-30.
//

import UIKit

class ProductsVC: UIViewController {


    var productList = [ProductData(itemNamePD: "Prime", itemImagePD: "img1"),ProductData(itemNamePD: "Deals & Savings", itemImagePD: "img2"),ProductData(itemNamePD: "Electronic Devices", itemImagePD: "img3"),ProductData(itemNamePD: "Fashion & Beauty", itemImagePD: "img4"),ProductData(itemNamePD: "Grocery", itemImagePD: "img5"),ProductData(itemNamePD: "Health & Personal Items", itemImagePD: "img6"),ProductData(itemNamePD: "Home, Furniture & Appliances", itemImagePD: "img7"),ProductData(itemNamePD: "Music, Video & Gaming", itemImagePD: "img8"),ProductData(itemNamePD: "FunZone & Inspiration", itemImagePD: "img9"),ProductData(itemNamePD: "Books and Education", itemImagePD: "img10"),ProductData(itemNamePD: "Toys, Children & Baby", itemImagePD: "img11"),ProductData(itemNamePD: "Automotive", itemImagePD: "img12"),ProductData(itemNamePD: "Office & Professional", itemImagePD: "img13"),ProductData(itemNamePD: "Sports, Outdoor & Travel", itemImagePD: "img14"),ProductData(itemNamePD: "Gifting", itemImagePD: "img15")]
    
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        
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
    
    
}
