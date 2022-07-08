//
//  ProductListVC.swift
//  Pick&PayStore
//
//  Created by Dhananjay H. Roy on 2022-07-01.
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
            tableList = ProductService.productServiceInstance.getElectronicsData()
            tableList.count
            print(tableList.count)
            
        case "TV & Appliances":
            print("TV & Appliances Selected")
            tableList = ProductService.productServiceInstance.getTVAndAppliancesData()
            tableList.count
            print(tableList.count)
            
        case "Women's Fashion":
            print("Women's Fashion Selected")
            tableList = ProductService.productServiceInstance.getWomensFashionData()
            tableList.count
            print(tableList.count)
            
        case "Men's Fashion":
            print("Men's Fashion Selected")
            tableList = ProductService.productServiceInstance.getMensFashionData()
            tableList.count
            print(tableList.count)
            
        case "Sports & Fitness":
            print("Sports & Fitness Selected")
            tableList = ProductService.productServiceInstance.getSportAndFitnessData()
            tableList.count
            print(tableList.count)
            
        case "Health & Beauty":
            print("Health & Beauty Selected")
            tableList = ProductService.productServiceInstance.getHealthAndBeautyData()
            tableList.count
            print(tableList.count)
            
        case "Footwear":
            print("Footwear Selected")
            tableList = ProductService.productServiceInstance.getFootwearData()
            tableList.count
            print(tableList.count)
            
        case "Travel":
            print("Travel Selected")
            tableList = ProductService.productServiceInstance.getTravelData()
            print(tableList.count)
            
        case "Kitchen":
            print("Kitchen Selected")
            tableList = ProductService.productServiceInstance.getKitchenData()
            tableList.count
            print(tableList.count)
            
        case "Furniture":
            print("Furniture Selected")
            tableList = ProductService.productServiceInstance.getFurnitureData()
            tableList.count
            print(tableList.count)
            
        case "Gardening & Outdoors":
            print("Gardening & Outdoors Selected")
            tableList = ProductService.productServiceInstance.getGardeningAndOutDoorData()
            tableList.count
            print(tableList.count)
            
        case "Books":
            print("Books Selected")
            tableList = ProductService.productServiceInstance.getBooksData()
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
            tableList = ProductService.productServiceInstance.getElectronicsData()
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
            tableList = ProductService.productServiceInstance.getTVAndAppliancesData()
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
            tableList = ProductService.productServiceInstance.getWomensFashionData()
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
            tableList = ProductService.productServiceInstance.getMensFashionData()
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
            tableList = ProductService.productServiceInstance.getSportAndFitnessData()
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
            tableList = ProductService.productServiceInstance.getHealthAndBeautyData()
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
            tableList = ProductService.productServiceInstance.getFootwearData()
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
            tableList = ProductService.productServiceInstance.getTravelData()
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
            tableList = ProductService.productServiceInstance.getKitchenData()
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
            tableList = ProductService.productServiceInstance.getFurnitureData()
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
            tableList = ProductService.productServiceInstance.getGardeningAndOutDoorData()
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
            tableList = ProductService.productServiceInstance.getBooksData()
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
        print(viewModel.nameDVM)
        print(viewModel.categoryDVM)
        print(viewModel.quantityDVM)
        print(viewModel.priceDVM)
        print(viewModel.imageDVM)
    }
}
