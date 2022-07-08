//
//  ProductsLisVC.swift
//  Pick&PayStore
//
//  Created by Dhananjay H. Roy on 2022-07-08.
//

import UIKit

class ProductListVC: UIViewController{
    
    var tableList = [DetailsTableData]()
    
    var itemList : String?
    var item : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item =  itemList!
        print(item,"Item Name")
        // Do any additional setup after loading the view.
       print(tableList,"tableList")
        switch item
        {
        case "Electronics":
            print("Electronics Selected")
            tableList = ProductDataService.productServiceInstance.getElectronicsData()
            tableList.count
            print(tableList.count)
            
        case "TV & Appliances":
            print("TV & Appliances Selected")
            tableList = ProductDataService.productServiceInstance.getTVAndAppliancesData()
            tableList.count
            print(tableList.count)
            
        case "Women's Fashion":
            print("Women's Fashion Selected")
            tableList = ProductDataService.productServiceInstance.getWomensFashionData()
            tableList.count
            print(tableList.count)
            
        case "Men's Fashion":
            print("Men's Fashion Selected")
            tableList = ProductDataService.productServiceInstance.getMensFashionData()
            tableList.count
            print(tableList.count)
            
        case "Sports & Fitness":
            print("Sports & Fitness Selected")
            tableList = ProductDataService.productServiceInstance.getSportAndFitnessData()
            tableList.count
            print(tableList.count)
            
        case "Health & Beauty":
            print("Health & Beauty Selected")
            tableList = ProductDataService.productServiceInstance.getHealthAndBeautyData()
            tableList.count
            print(tableList.count)
            
        case "Footwear":
            print("Footwear Selected")
            tableList = ProductDataService.productServiceInstance.getFootwearData()
            tableList.count
            print(tableList.count)
            
        case "Travel":
            print("Travel Selected")
            tableList = ProductDataService.productServiceInstance.getTravelData()
            print(tableList.count)
            
        case "Kitchen":
            print("Kitchen Selected")
            tableList = ProductDataService.productServiceInstance.getKitchenData()
            tableList.count
            print(tableList.count)
            
        case "Furniture":
            print("Furniture Selected")
            tableList = ProductDataService.productServiceInstance.getFurnitureData()
            tableList.count
            print(tableList.count)
            
        case "Gardening & Outdoors":
            print("Gardening & Outdoors Selected")
            tableList = ProductDataService.productServiceInstance.getGardeningAndOutDoorData()
            tableList.count
            print(tableList.count)
            
        case "Books":
            print("Books Selected")
            tableList = ProductDataService.productServiceInstance.getBooksData()
            tableList.count
            print(tableList.count)
            
        default:
            print("")
        }

    }
    

}

extension ProductListVC: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableList.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "lList") as! SubTVC
        
        switch item
        {
        case "Electronics":
            print("Electronics Selected")
            tableList = ProductDataService.productServiceInstance.getElectronicsData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
            
        case "TV & Appliances":
            print("TV & Appliances Selected")
            tableList = ProductDataService.productServiceInstance.getTVAndAppliancesData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Women's Fashion":
            print("Women's Fashion Selected")
            tableList = ProductDataService.productServiceInstance.getWomensFashionData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Men's Fashion":
            print("Men's Fashion Selected")
            tableList = ProductDataService.productServiceInstance.getMensFashionData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Sports & Fitness":
            print("Sports & Fitness Selected")
            tableList = ProductDataService.productServiceInstance.getSportAndFitnessData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Health & Beauty":
            print("Health & Beauty Selected")
            tableList = ProductDataService.productServiceInstance.getHealthAndBeautyData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Footwear":
            print("Footwear Selected")
            tableList = ProductDataService.productServiceInstance.getFootwearData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Travel":
            print("Travel Selected")
            tableList = ProductDataService.productServiceInstance.getTravelData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Kitchen":
            print("Kitchen Selected")
            tableList = ProductDataService.productServiceInstance.getKitchenData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Furniture":
            print("Furniture Selected")
            tableList = ProductDataService.productServiceInstance.getFurnitureData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Gardening & Outdoors":
            print("Gardening & Outdoors Selected")
            tableList = ProductDataService.productServiceInstance.getGardeningAndOutDoorData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
        case "Books":
            print("Books Selected")
            tableList = ProductDataService.productServiceInstance.getBooksData()
            print(tableList)
            let model = tableList[indexPath.row]
            print(model)
            let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
            cell.tableListLabel.text = viewModel.nameDVM
            cell.tableListImage.image = UIImage(named: viewModel.imageDVM)
            cell.tableListPrice.text = "Price: $" + viewModel.priceDVM
            cell.tableListQty.text = "Qty:" + viewModel.quantityDVM
            
            
        default:
            print("")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = tableList[indexPath.row]
        let viewModel = DetailsViewModel(nameDVM: model.nameDM, priceDVM: model.priceDM, quantityDVM: model.quantityDM, imageDVM: model.imageDM, categoryDVM: model.categoryDM)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "productdetailsVC") as! ProductsDisplayVC
        vc.itemName = viewModel.nameDVM
        vc.itemCategory = viewModel.categoryDVM
        vc.itemQty = viewModel.quantityDVM
        vc.itemPrice = viewModel.priceDVM
        vc.itemImageName = viewModel.imageDVM
        self.present(vc, animated:  true, completion: nil)
        print("name DVM",viewModel.nameDVM)
        print("category DVM",viewModel.categoryDVM)
        print("quantity DVM",viewModel.quantityDVM)
        print("price DVM",viewModel.priceDVM)
        print("image DVM",viewModel.imageDVM)
    }
}

