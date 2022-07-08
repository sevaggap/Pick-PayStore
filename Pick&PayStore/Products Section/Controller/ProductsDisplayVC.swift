//
//  ProductsDisplayVC.swift
//  Pick&PayStore
//
//  Created by Dhananjay H. Roy on 2022-07-08.
//

import UIKit

class ProductsDisplayVC: UIViewController {

    var collectionList = [DetailsTableData]()
    
    var imageList = [ProductImageData]()
    
    var itemName: String?
    var itemQty: String?
    var itemCategory: String?
    var itemPrice: String?
    var itemImageName: String?
    
    var item: String = ""
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductItemName: UILabel!
    @IBOutlet weak var ProductCategory: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductQuantity: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item = itemName!
        print(item,"Collection Item Name")
        
        print(collectionList, "Collection list")
        
        switch item
        {
        case "The Fault in Our Stars By John Green":
            imageList = ProductDataService.productServiceInstance.getFaultInStarsImageData()
            imageList.count
        case "The Life of Pi By Yann Martel":
            imageList = ProductDataService.productServiceInstance.getLifeOfPiImageData()
            imageList.count
        case "Milk and Honey By Rupi Kuar":
            imageList = ProductDataService.productServiceInstance.getMilkAndHoneyImageData()
            imageList.count
        case "The Hunger Games By Suzanne Collins":
            imageList = ProductDataService.productServiceInstance.getHungerGamesImageData()
            imageList.count
        case "The City of Bones By Cassandra Blare":
            imageList = ProductDataService.productServiceInstance.getCityOfBonesImageData()
            imageList.count
        case "Jumbo Poly Leaf Rake":
            imageList = ProductDataService.productServiceInstance.getLeafRakeImageData()
            imageList.count
        case "Garden Hose":
            imageList = ProductDataService.productServiceInstance.getGardenHoseImageData()
            imageList.count
        case "Backyard Gazebo":
            imageList = ProductDataService.productServiceInstance.getGazeboImageData()
            imageList.count
        case "Lawn Chair":
            imageList = ProductDataService.productServiceInstance.getLawnChairImageData()
            imageList.count
        case "Gas BBQ":
            imageList = ProductDataService.productServiceInstance.getBBQImageData()
            imageList.count
        case "White Fabric Right Sectional Sofa":
            imageList = ProductDataService.productServiceInstance.getSofaImageData()
            imageList.count
        case "Footstoll with Storage":
            imageList = ProductDataService.productServiceInstance.getFootstoollImageData()
            imageList.count
        case "Tan Recliner":
            imageList = ProductDataService.productServiceInstance.getReclinerImageData()
            imageList.count
        case "Wodden Dinning Room Table Set":
            imageList = ProductDataService.productServiceInstance.getDiningSetImageData()
            imageList.count
        case "Coffee Table":
            imageList = ProductDataService.productServiceInstance.getCoffeeTableImageData()
            imageList.count
        case "Kitchenaid Custom Stand Mixer - 4.5 QT - 325-Watt":
            imageList = ProductDataService.productServiceInstance.getMixerImageData()
            imageList.count
        case "Kitchen Towels":
            imageList = ProductDataService.productServiceInstance.getTowelsImageData()
            imageList.count
        case "56 Piece Cutlery Set":
            imageList = ProductDataService.productServiceInstance.getCutlerySetImageData()
            imageList.count
        case "18 Piece Dinnerware Set":
            imageList = ProductDataService.productServiceInstance.getDinnerwareImageData()
            imageList.count
        case "Clear Glass Set":
            imageList = ProductDataService.productServiceInstance.getGlassSetImageData()
            imageList.count
        case "Fosmon Luggage Lock - 3 Piece":
            imageList = ProductDataService.productServiceInstance.getLuggageSetImageData()
            imageList.count
        case "3 Piece Luggage Set":
            imageList = ProductDataService.productServiceInstance.getLuggageSetImageData()
            imageList.count
        case "Neck Pillow":
            imageList = ProductDataService.productServiceInstance.getPillowImageData()
            imageList.count
        case "Passport Holder":
            imageList = ProductDataService.productServiceInstance.getPassportImageData()
            imageList.count
        case "Mini Handheld Fan":
            imageList = ProductDataService.productServiceInstance.getMiniFanImageData()
            imageList.count
        case "Black Crocs":
            imageList = ProductDataService.productServiceInstance.getCrocsImageData()
            imageList.count
        case "Tan Timberland Boots":
            imageList = ProductDataService.productServiceInstance.getTimberlandImageData()
            imageList.count
        case "Nike Jordan 1 Mid Light Smoke Grey":
            imageList = ProductDataService.productServiceInstance.getJordanImageData()
            imageList.count
        case "Nike Slides":
            imageList = ProductDataService.productServiceInstance.getSlidesImageData()
            imageList.count
        case "Women's Tan Summer Sandles":
            imageList = ProductDataService.productServiceInstance.getSandlesImageData()
            imageList.count
        case "Hydro Flask Water Bottle":
            imageList = ProductDataService.productServiceInstance.getFlaskImageData()
            imageList.count
            
        case "25 LB Dumbbells":
            imageList = ProductDataService.productServiceInstance.getDumbbellsImageData()
            imageList.count
            
        case "Resistance Bands":
            imageList = ProductDataService.productServiceInstance.getResistanceBandsImageData()
            imageList.count
            
        case "Yoga Mat":
            imageList = ProductDataService.productServiceInstance.getYogaMatImageData()
            imageList.count
            
        case "Gym Bag":
            imageList = ProductDataService.productServiceInstance.getGymBagImageData()
            imageList.count
            
        case "Diesel Protein Powder":
            imageList = ProductDataService.productServiceInstance.getDieselImageData()
            imageList.count
            
        case "L'Oreal Paris - Voluminous Lash Paradise Mascara":
            imageList = ProductDataService.productServiceInstance.getMascaraImageData()
            imageList.count
            
        case "Nail Clippers":
            imageList = ProductDataService.productServiceInstance.getNailClipperImageData()
            imageList.count
            
        case "Head & Shoulders Shampoo":
            imageList = ProductDataService.productServiceInstance.getShampooImageData()
            imageList.count
            
        case "Head & Shoulders Conditioner":
            imageList = ProductDataService.productServiceInstance.getConditionerImageData()
            imageList.count
            
        case "LG French Door Refriderator 36 inch - Width 27.9 cu ft Capacity":
            imageList = ProductDataService.productServiceInstance.getlgImageData()
            imageList.count
            
        case "Samsung -  Smart TV - 50 TU7000 4K Ultra HDR Smart TV":
            imageList = ProductDataService.productServiceInstance.getSamsungImageData()
            imageList.count
            
        case "Frigidaire EFIC108-Red Compact Ice Maker":
            imageList = ProductDataService.productServiceInstance.getFrigidaireImageData()
            imageList.count
            
        case "TCL - Smart TV - 3 Series 32 1080p HD LED Roku Smart TV":
            imageList = ProductDataService.productServiceInstance.getTCLImageData()
            imageList.count
            
        case "Frigidaire Gas - FCRG3052AS Range Free Stading Gas Range 30":
            imageList = ProductDataService.productServiceInstance.getGasImageData()
            imageList.count
            
        case "Women's Cozy Button Up Cardigan":
            imageList = ProductDataService.productServiceInstance.getCardiganImageData()
            imageList.count
            
        case "Yellow Sun Dress":
            imageList = ProductDataService.productServiceInstance.getDressImageData()
            imageList.count
            
        case "Levi's - 501 '90s Womens Shorts":
            imageList = ProductDataService.productServiceInstance.getShortsImageData()
            imageList.count
            
        case "Women's Knit Drop Shoulder Pullover":
            imageList = ProductDataService.productServiceInstance.getPulloverImageData()
            imageList.count
            
        case "Women's Zipper Front Biker Jacket":
            imageList = ProductDataService.productServiceInstance.getJacketImageData()
            imageList.count
            
        case "Hawaiian Button Up Shirt":
            imageList = ProductDataService.productServiceInstance.getShirtImageData()
            imageList.count
            
        case "Levi's - 505 Regular Fit 10inch Men Shorts":
            imageList = ProductDataService.productServiceInstance.getMLevisShortsImageData()
            imageList.count
            
        case "Men's Tan Cargo Shorts":
            imageList = ProductDataService.productServiceInstance.getMshortsImageData()
            imageList.count
            
        case "Men's Sweatshirt":
            imageList = ProductDataService.productServiceInstance.getSweatshirtImageData()
            imageList.count
            
        case "Classic Cotton T-Shirt":
            imageList = ProductDataService.productServiceInstance.getTshirtImageData()
            imageList.count
            
        case "Sony WH1000MX5":
            imageList = ProductDataService.productServiceInstance.getSonyImageData()
            imageList.count
            
        case "Nintendo Switch":
            imageList = ProductDataService.productServiceInstance.getNintendoImageData()
            imageList.count
            
        case "Razer Basilisk X HyperSpeed Mouse":
            imageList = ProductDataService.productServiceInstance.getRazerMouseImageData()
            imageList.count
            
        case "FujiFilm Instax Mini 11":
            imageList = ProductDataService.productServiceInstance.getFujifilmImageData()
            imageList.count
            
        case "Razer Cynosa V2 Gaming Keyboard":
            imageList = ProductDataService.productServiceInstance.getRazerKeyboardImageData()
            imageList.count
            
        default:
            print("")
        }
       displayDetails()
    }
    
    func displayDetails()
    {
       // ProductImage.image = UIImage(named: itemImageName ?? "")
        ProductItemName.text = itemName ?? item
        ProductQuantity.text = "Quantity: " + itemQty!
        ProductCategory.text = "Category: " + itemCategory!
        ProductPrice.text = "Price: $" + itemPrice!

    }

}


extension ProductsDisplayVC: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! DetailCVC
        switch item
        {
        case "The Life of Pi By Yann Martel":
            imageList = ProductDataService.productServiceInstance.getLifeOfPiImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
        case "Milk and Honey By Rupi Kuar":
            imageList = ProductDataService.productServiceInstance.getMilkAndHoneyImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
        case "The Hunger Games By Suzanne Collins":
            imageList = ProductDataService.productServiceInstance.getHungerGamesImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
        case "The City of Bones By Cassandra Blare":
            imageList = ProductDataService.productServiceInstance.getCityOfBonesImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
        case "The Fault in Our Stars By John Green":
            imageList = ProductDataService.productServiceInstance.getFaultInStarsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Jumbo Poly Leaf Rake":
            imageList = ProductDataService.productServiceInstance.getLeafRakeImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Garden Hose":
            imageList = ProductDataService.productServiceInstance.getGardenHoseImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Backyard Gazebo":
            imageList = ProductDataService.productServiceInstance.getGazeboImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Lawn Chair":
            imageList = ProductDataService.productServiceInstance.getLawnChairImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Gas BBQ":
            imageList = ProductDataService.productServiceInstance.getBBQImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "White Fabric Right Sectional Sofa":
            imageList = ProductDataService.productServiceInstance.getSofaImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Footstoll with Storage":
            imageList = ProductDataService.productServiceInstance.getFootstoollImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Tan Recliner":
            imageList = ProductDataService.productServiceInstance.getReclinerImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Wodden Dinning Room Table Set":
            imageList = ProductDataService.productServiceInstance.getDiningSetImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Coffee Table":
            imageList = ProductDataService.productServiceInstance.getCoffeeTableImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Kitchenaid Custom Stand Mixer - 4.5 QT - 325-Watt":
            imageList = ProductDataService.productServiceInstance.getMixerImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Kitchen Towels":
            imageList = ProductDataService.productServiceInstance.getTowelsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "56 Piece Cutlery Set":
            imageList = ProductDataService.productServiceInstance.getCutlerySetImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "18 Piece Dinnerware Set":
            imageList = ProductDataService.productServiceInstance.getDinnerwareImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Clear Glass Set":
            imageList = ProductDataService.productServiceInstance.getGlassSetImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Fosmon Luggage Lock - 3 Piece":
            imageList = ProductDataService.productServiceInstance.getLuggageSetImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "3 Piece Luggage Set":
            imageList = ProductDataService.productServiceInstance.getLuggageSetImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Neck Pillow":
            imageList = ProductDataService.productServiceInstance.getPillowImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Passport Holder":
            imageList = ProductDataService.productServiceInstance.getPassportImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Mini Handheld Fan":
            imageList = ProductDataService.productServiceInstance.getMiniFanImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Black Crocs":
            imageList = ProductDataService.productServiceInstance.getCrocsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Tan Timberland Boots":
            imageList = ProductDataService.productServiceInstance.getTimberlandImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Nike Jordan 1 Mid Light Smoke Grey":
            imageList = ProductDataService.productServiceInstance.getJordanImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Nike Slides":
            imageList = ProductDataService.productServiceInstance.getSlidesImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Women's Tan Summer Sandles":
            imageList = ProductDataService.productServiceInstance.getSandlesImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Hydro Flask Water Bottle":
            imageList = ProductDataService.productServiceInstance.getFlaskImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "25 LB Dumbbells":
            imageList = ProductDataService.productServiceInstance.getDumbbellsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Resistance Bands":
            imageList = ProductDataService.productServiceInstance.getResistanceBandsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Yoga Mat":
            imageList = ProductDataService.productServiceInstance.getYogaMatImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Gym Bag":
            imageList = ProductDataService.productServiceInstance.getGymBagImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Diesel Protein Powder":
            imageList = ProductDataService.productServiceInstance.getDieselImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "L'Oreal Paris - Voluminous Lash Paradise Mascara":
            imageList = ProductDataService.productServiceInstance.getMascaraImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Nail Clippers":
            imageList = ProductDataService.productServiceInstance.getNailClipperImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Head & Shoulders Shampoo":
            imageList = ProductDataService.productServiceInstance.getShampooImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Head & Shoulders Conditioner":
            imageList = ProductDataService.productServiceInstance.getConditionerImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "LG French Door Refriderator 36 inch - Width 27.9 cu ft Capacity":
            imageList = ProductDataService.productServiceInstance.getlgImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Samsung -  Smart TV - 50 TU7000 4K Ultra HDR Smart TV":
            imageList = ProductDataService.productServiceInstance.getSamsungImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Frigidaire EFIC108-Red Compact Ice Maker":
            imageList = ProductDataService.productServiceInstance.getFrigidaireImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "TCL - Smart TV - 3 Series 32 1080p HD LED Roku Smart TV":
            imageList = ProductDataService.productServiceInstance.getTCLImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Frigidaire Gas - FCRG3052AS Range Free Stading Gas Range 30":
            imageList = ProductDataService.productServiceInstance.getGasImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Women's Cozy Button Up Cardigan":
            imageList = ProductDataService.productServiceInstance.getCardiganImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Yellow Sun Dress":
            imageList = ProductDataService.productServiceInstance.getDressImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Levi's - 501 '90s Womens Shorts":
            imageList = ProductDataService.productServiceInstance.getShortsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Women's Knit Drop Shoulder Pullover":
            imageList = ProductDataService.productServiceInstance.getPulloverImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Women's Zipper Front Biker Jacket":
            imageList = ProductDataService.productServiceInstance.getJacketImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Hawaiian Button Up Shirt":
            imageList = ProductDataService.productServiceInstance.getShirtImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Levi's - 505 Regular Fit 10inch Men Shorts":
            imageList = ProductDataService.productServiceInstance.getMLevisShortsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Men's Tan Cargo Shorts":
            imageList = ProductDataService.productServiceInstance.getMshortsImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Men's Sweatshirt":
            imageList = ProductDataService.productServiceInstance.getSweatshirtImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Classic Cotton T-Shirt":
            imageList = ProductDataService.productServiceInstance.getTshirtImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Sony WH1000MX5":
            imageList = ProductDataService.productServiceInstance.getSonyImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Nintendo Switch":
            imageList = ProductDataService.productServiceInstance.getNintendoImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Razer Basilisk X HyperSpeed Mouse":
            imageList = ProductDataService.productServiceInstance.getRazerMouseImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "FujiFilm Instax Mini 11":
            imageList = ProductDataService.productServiceInstance.getFujifilmImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        case "Razer Cynosa V2 Gaming Keyboard":
            imageList = ProductDataService.productServiceInstance.getRazerKeyboardImageData()
            let model = imageList[indexPath.row]
            let viewModel = ProductImageViewModel(imagePIVM: model.imagePID)
            cell.ProductImage.image = UIImage(named: viewModel.imagePIVM)
            
        default:
            print("")
        }
        return cell
    }
    
    
}



