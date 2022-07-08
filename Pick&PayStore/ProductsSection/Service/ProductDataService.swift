//
//  ProductDataService.swift
//  Pick&PayStore
//
//  Created by Dhananjay H. Roy on 2022-07-02.
//

import Foundation

class ProductService
{
    static var productServiceInstance = ProductService()
    
    func getData() -> [ProductData]
    {
        let productData = [ProductData(itemNamePD: "Electronics", itemImagePD: "electronics"),
                           ProductData(itemNamePD: "TV & Appliances", itemImagePD: "tv-appliances"),
                           ProductData(itemNamePD: "Women's Fashion", itemImagePD: "women-clothes"),
                           ProductData(itemNamePD: "Men's Fashion", itemImagePD: "men-clothes"),
                           ProductData(itemNamePD: "Sports & Fitness", itemImagePD: "sports-fitness"),
                           ProductData(itemNamePD: "Health & Beauty", itemImagePD: "health-beauty"),
                           ProductData(itemNamePD: "Footwear", itemImagePD: "footwear"),
                           ProductData(itemNamePD: "Travel", itemImagePD: "travel"),
                           ProductData(itemNamePD: "Kitchen", itemImagePD: "kitchen"),
                           ProductData(itemNamePD: "Furniture", itemImagePD: "furniture"),
                           ProductData(itemNamePD: "Gardening & Outdoors", itemImagePD: "GardenAndOutdoors"),
                           ProductData(itemNamePD: "Books", itemImagePD: "books")]
        
        return productData
    }
    
    func getElectronicsData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Sony WH1000MX5", priceDM: "499.99", quantityDM: "10", imageDM: "Sony", categoryDM: "Electronics"),
                              DetailsTableData(nameDM: "Nintendo Switch", priceDM: "379.99", quantityDM: "10", imageDM: "Nintendo", categoryDM: "Electronics"),
                              DetailsTableData(nameDM: "Razer Basilisk X HyperSpeed Mouse", priceDM: "79.99", quantityDM: "10", imageDM: "RazerMouse", categoryDM: "Electronics"),
                              DetailsTableData(nameDM: "FujiFilm Instax Mini 11", priceDM: "99.99", quantityDM: "10", imageDM: "Fujifilm", categoryDM: "Electronics"),
                              DetailsTableData(nameDM: "Razer Cynosa V2 Gaming Keyboard", priceDM: "79.99", quantityDM: "10", imageDM: "RazerKeyboard", categoryDM: "Electronics")]
        return collectionData
    }
    
    func getTVAndAppliancesData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "LG French Door Refriderator 36 inch - Width 27.9 cu ft Capacity", priceDM: "2794.99", quantityDM: "10", imageDM: "lg", categoryDM: "TV & Appliances"),
                              DetailsTableData(nameDM: "Samsung -  Smart TV - 50 TU7000 4K Ultra HDR Smart TV", priceDM: "648.00", quantityDM: "10", imageDM: "Samsung", categoryDM: "TV & Appliances"),
                              DetailsTableData(nameDM: "Frigidaire EFIC108-Red Compact Ice Maker", priceDM: "129.99", quantityDM: "10", imageDM: "Frigidaire", categoryDM: "TV & Appliances"),
                              DetailsTableData(nameDM: "TCL - Smart TV - 3 Series 32 1080p HD LED Roku Smart TV", priceDM: "230.00", quantityDM: "10", imageDM: "TCL", categoryDM: "TV & Appliances"),
                              DetailsTableData(nameDM: "Frigidaire Gas - FCRG3052AS Range Free Stading Gas Range 30", priceDM: "994.99", quantityDM: "10", imageDM: "Gas", categoryDM: "TV & Appliances")]
        return collectionData
    }
    
    func getWomensFashionData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Women's Cozy Button Up Cardigan", priceDM: "14.99", quantityDM: "10", imageDM: "Cardigan", categoryDM: "Women's Fashion"),
                              DetailsTableData(nameDM: "Yellow Sun Dress", priceDM: "29.99", quantityDM: "10", imageDM: "Dress", categoryDM: "Women's Fashion"),
                              DetailsTableData(nameDM: "Levi's - 501 '90s Womens Shorts", priceDM: "88.99", quantityDM: "10", imageDM: "Shorts", categoryDM: "Women's Fashion"),
                              DetailsTableData(nameDM: "Women's Knit Drop Shoulder Pullover", priceDM: "19.99", quantityDM: "10", imageDM: "Pullover", categoryDM: "Women's Fashion"),
                              DetailsTableData(nameDM: "Women's Zipper Front Biker Jacket", priceDM: "39.99", quantityDM: "10", imageDM: "Jacket", categoryDM: "Women's Fashion")]
        return collectionData
    }
    
    func getMensFashionData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Hawaiian Button Up Shirt", priceDM: "16.99", quantityDM: "10", imageDM: "Shirt", categoryDM: "Men's Fashion"),
                              DetailsTableData(nameDM: "Levi's - 505 Regular Fit 10inch Men Shorts", priceDM: "49.98", quantityDM: "10", imageDM: "MLevisShorts", categoryDM: "Men's Fashion"),
                              DetailsTableData(nameDM: "Men's Tan Cargo Shorts", priceDM: "39.99", quantityDM: "10", imageDM: "Mshorts", categoryDM: "Men's Fashion"),
                              DetailsTableData(nameDM: "Men's Sweatshirt", priceDM: "49.99", quantityDM: "10", imageDM: "Sweatshirt", categoryDM: "Men's Fashion"),
                              DetailsTableData(nameDM: "Classic Cotton T-Shirt", priceDM: "9.99", quantityDM: "10", imageDM: "Tshirt", categoryDM: "Men's Fashion")]
        return collectionData
    }
    
    func getSportAndFitnessData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Hydro Flask Water Bottle", priceDM: "35.99", quantityDM: "10", imageDM: "Flask", categoryDM: "Sports & Fitness"),
                              DetailsTableData(nameDM: "25 LB Dumbbells", priceDM: "27.99", quantityDM: "10", imageDM: "Dumbbells", categoryDM: "Sports & Fitness"),
                              DetailsTableData(nameDM: "Resistance Bands", priceDM: "9.99", quantityDM: "10", imageDM: "ResistanceBands", categoryDM: "Sports & Fitness"),
                              DetailsTableData(nameDM: "Yoga Mat", priceDM: "35.99", quantityDM: "10", imageDM: "YogaMat", categoryDM: "Sports & Fitness"),
                              DetailsTableData(nameDM: "Gym Bag", priceDM: "46.99", quantityDM: "10", imageDM: "GymBag", categoryDM: "Sports & Fitness")]
        return collectionData
    }
    
    func getHealthAndBeautyData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Diesel Protein Powder", priceDM: "114.99", quantityDM: "10", imageDM: "Diesel", categoryDM: "Health & Beauty"),
                              DetailsTableData(nameDM: "L'Oreal Paris - Voluminous Lash Paradise Mascara", priceDM: "11.96", quantityDM: "10", imageDM: "Mascara", categoryDM: "Health & Beauty"),
                              DetailsTableData(nameDM: "Nail Clippers", priceDM: "10.99", quantityDM: "10", imageDM: "NailClipper", categoryDM: "Health & Beauty"),
                              DetailsTableData(nameDM: "Head & Shoulders Shampoo", priceDM: "8.99", quantityDM: "10", imageDM: "Shampoo", categoryDM: "Health & Beauty"),
                              DetailsTableData(nameDM: "Head & Shoulders Conditioner", priceDM: "8.99", quantityDM: "10", imageDM: "Conditioner", categoryDM: "Health & Beauty")]
        return collectionData
    }
    
    func getFootwearData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Black Crocs", priceDM: "59.99", quantityDM: "10", imageDM: "Crocs", categoryDM: "Footwear"),
                              DetailsTableData(nameDM: "Tan Timberland Boots", priceDM: "110.00", quantityDM: "10", imageDM: "Timberland", categoryDM: "Footwear"),
                              DetailsTableData(nameDM: "Nike Jordan 1 Mid Light Smoke Grey", priceDM: "350.00", quantityDM: "10", imageDM: "Jordan", categoryDM: "Footwear"),
                              DetailsTableData(nameDM: "Nike Slides", priceDM: "19.99", quantityDM: "10", imageDM: "Slides", categoryDM: "Footwear"),
                              DetailsTableData(nameDM: "Women's Tan Summer Sandles", priceDM: "59.99", quantityDM: "10", imageDM: "Sandles", categoryDM: "Footwear")]
        return collectionData
    }
    
    func getTravelData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Fosmon Luggage Lock - 3 Piece", priceDM: "22.95", quantityDM: "10", imageDM: "Lock", categoryDM: "Travel"),
                              DetailsTableData(nameDM: "3 Piece Luggage Set", priceDM: "139.99", quantityDM: "10", imageDM: "LuggageSet", categoryDM: "Travel"),
                              DetailsTableData(nameDM: "Neck Pillow", priceDM: "49.99", quantityDM: "10", imageDM: "Pillow", categoryDM: "Travel"),
                              DetailsTableData(nameDM: "Passport Holder", priceDM: "19.99", quantityDM: "10", imageDM: "Passport", categoryDM: "Travel"),
                              DetailsTableData(nameDM: "Mini Handheld Fan", priceDM: "26.99", quantityDM: "10", imageDM: "MiniFan", categoryDM: "Travel")]
        return collectionData
    }
    
    func getKitchenData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Kitchenaid Custom Stand Mixer - 4.5 QT - 325-Watt", priceDM: "499.99", quantityDM: "10", imageDM: "Mixer", categoryDM: "Kitchen"),
                              DetailsTableData(nameDM: "Kitchen Towels", priceDM: "9.99", quantityDM: "10", imageDM: "Towels", categoryDM: "Kitchen"),
                              DetailsTableData(nameDM: "56 Piece Cutlery Set", priceDM: "59.99", quantityDM: "10", imageDM: "CutlerySet", categoryDM: "Kitchen"),
                              DetailsTableData(nameDM: "18 Piece Dinnerware Set", priceDM: "59.99", quantityDM: "10", imageDM: "Dinnerware", categoryDM: "Kitchen"),
                              DetailsTableData(nameDM: "Clear Glass Set", priceDM: "8.99", quantityDM: "10", imageDM: "GlassSet", categoryDM: "Kitchen")]
        return collectionData
    }
    
    func getFurnitureData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "White Fabric Right Sectional Sofa", priceDM: "999.99", quantityDM: "10", imageDM: "Sofa", categoryDM: "Furniture"),
                              DetailsTableData(nameDM: "Footstoll with Storage", priceDM: "99.99", quantityDM: "10", imageDM: "Footstooll", categoryDM: "Furniture"),
                              DetailsTableData(nameDM: "Tan Recliner", priceDM: "399.99", quantityDM: "10", imageDM: "Recliner", categoryDM: "Furniture"),
                              DetailsTableData(nameDM: "Wodden Dinning Room Table Set", priceDM: "689.99", quantityDM: "10", imageDM: "DiningSet", categoryDM: "Furniture"),
                              DetailsTableData(nameDM: "Coffee Table", priceDM: "69.99", quantityDM: "10", imageDM: "CoffeeTable", categoryDM: "Furniture")]
        return collectionData
    }
    
    func getGardeningAndOutDoorData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "Jumbo Poly Leaf Rake", priceDM: "19.99", quantityDM: "10", imageDM: "LeafRake", categoryDM: "Gardening & Outdoors"),
                              DetailsTableData(nameDM: "Garden Hose", priceDM: "99.99", quantityDM: "10", imageDM: "GardenHose", categoryDM: "Gardening & Outdoors"),
                              DetailsTableData(nameDM: "Backyard Gazebo", priceDM: "399.99", quantityDM: "10", imageDM: "Gazebo", categoryDM: "Gardening & Outdoors"),
                              DetailsTableData(nameDM: "Lawn Chair", priceDM: "19.99", quantityDM: "10", imageDM: "LawnChair", categoryDM: "Gardening & Outdoors"),
                              DetailsTableData(nameDM: "Gas BBQ", priceDM: "629.99", quantityDM: "10", imageDM: "BBQ", categoryDM: "Gardening & Outdoors")]
        return collectionData
    }
   
    func getBooksData() -> [DetailsTableData]
    {
        let collectionData = [DetailsTableData(nameDM: "The Life of Pi By Yann Martel", priceDM: "11.99", quantityDM: "10", imageDM: "LifeOfPi", categoryDM: "Books"),
                              DetailsTableData(nameDM: "Milk and Honey By Rupi Kuar", priceDM: "19.99", quantityDM: "10", imageDM: "MilkAndHoney", categoryDM: "Books"),
                              DetailsTableData(nameDM: "The Hunger Games By Suzanne Collins", priceDM: "16.99", quantityDM: "10", imageDM: "HungerGames", categoryDM: "Books"),
                              DetailsTableData(nameDM: "The City of Bones By Cassandra Blare", priceDM: "16.99", quantityDM: "10", imageDM: "CityOfBones", categoryDM: "Books"),
                              DetailsTableData(nameDM: "The Fault in Our Stars By John Green", priceDM: "14.99", quantityDM: "10", imageDM: "TheFaultInOurStars", categoryDM: "Books")]
        return collectionData
    }
    
    func getFaultInStarsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "TheFaultInOurStars"),ProductImageData(imagePID: "thefaultinourstars2"),ProductImageData(imagePID: "thefaultinourstars3")]
        
        return imageData
    }
    
    func getCityOfBonesImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "CityOfBones"),ProductImageData(imagePID: "CityOfBones1"),ProductImageData(imagePID: "CityOfBones2")]
        
        return imageData
    }
    
    func getHungerGamesImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "HungerGames"),ProductImageData(imagePID: "HungerGames1"),ProductImageData(imagePID: "HungerGames2")]
        
        return imageData
    }
    
    func getMilkAndHoneyImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "MilkAndHoney"),ProductImageData(imagePID: "MilkAndHoney1"),ProductImageData(imagePID: "MilkAndHoney2")]
        
        return imageData
    }
    
    func getLifeOfPiImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "LifeOfPi"),ProductImageData(imagePID: "LifeOfPi1"),ProductImageData(imagePID: "LifeOfPi2")]
        
        return imageData
    }
    
    func getLeafRakeImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "LeafRake"),ProductImageData(imagePID: "LeafRake1"),ProductImageData(imagePID: "LeafRake2")]
        
        return imageData
    }
    
    func getGardenHoseImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "GardenHose"),ProductImageData(imagePID: "GardenHose1"),ProductImageData(imagePID: "GardenHose2")]
        
        return imageData
    }
    
    func getGazeboImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Gazebo"),ProductImageData(imagePID: "Gazebo1"),ProductImageData(imagePID: "Gazebo2")]
        
        return imageData
    }
    
    func getLawnChairImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "LawnChair"),ProductImageData(imagePID: "LawnChair1"),ProductImageData(imagePID: "LawnChair2")]
        
        return imageData
    }
    
    func getBBQImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "BBQ"),ProductImageData(imagePID: "BBQ1"),ProductImageData(imagePID: "BBQ2")]
        
        return imageData
    }
    
    func getFootstoollImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Footstooll"),ProductImageData(imagePID: "Footstooll1"),ProductImageData(imagePID: "Footstooll2")]
        
        return imageData
    }
    
    func getSofaImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Sofa"),ProductImageData(imagePID: "Sofa1"),ProductImageData(imagePID: "Sofa2")]
        
        return imageData
    }
    
    func getReclinerImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Recliner"),ProductImageData(imagePID: "Recliner1"),ProductImageData(imagePID: "Recliner2")]
        
        return imageData
    }
    
    func getDiningSetImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "DiningSet"),ProductImageData(imagePID: "DiningSet1"),ProductImageData(imagePID: "DiningSet2")]
        
        return imageData
    }
    
    func getCoffeeTableImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "CoffeeTable"),ProductImageData(imagePID: "CoffeeTable1"),ProductImageData(imagePID: "CoffeeTable2")]
        
        return imageData
    }
    
    func getMixerImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Mixer"),ProductImageData(imagePID: "Mixer1"),ProductImageData(imagePID: "Mixer2")]
        
        return imageData
    }
    
    func getTowelsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Towels"),ProductImageData(imagePID: "Towels1"),ProductImageData(imagePID: "Towels2")]
        
        return imageData
    }
    
    func getCutlerySetImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "CutlerySet"),ProductImageData(imagePID: "CutlerySet1"),ProductImageData(imagePID: "CutlerySet2")]
        
        return imageData
    }
    
    func getDinnerwareImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Dinnerware"),ProductImageData(imagePID: "Dinnerware1"),ProductImageData(imagePID: "Dinnerware2")]
        
        return imageData
    }
    
    func getGlassSetImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "GlassSet"),ProductImageData(imagePID: "GlassSet1"),ProductImageData(imagePID: "GlassSet2")]
        
        return imageData
    }
    
    func getLockImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Lock"),ProductImageData(imagePID: "Lock1"),ProductImageData(imagePID: "Lock2")]
        
        return imageData
    }
    
    func getLuggageSetImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "LuggageSet"),ProductImageData(imagePID: "LuggageSet1"),ProductImageData(imagePID: "LuggageSet2")]
        
        return imageData
    }
    
    func getPillowImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Pillow"),ProductImageData(imagePID: "Pillow1"),ProductImageData(imagePID: "Pillow2")]
        
        return imageData
    }
    
    func getPassportImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Passport"),ProductImageData(imagePID: "Passport1"),ProductImageData(imagePID: "Passport2")]
        
        return imageData
    }
    
    func getMiniFanImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "MiniFan"),ProductImageData(imagePID: "MiniFan1"),ProductImageData(imagePID: "MiniFan2")]
        
        return imageData
    }
    
    func getCrocsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Crocs"),ProductImageData(imagePID: "Crocs1"),ProductImageData(imagePID: "Crocs2")]
        
        return imageData
    }
    
    func getTimberlandImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Timberland"),ProductImageData(imagePID: "Timberland1"),ProductImageData(imagePID: "Timberland2")]
        
        return imageData
    }
    
    func getJordanImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Jordan"),ProductImageData(imagePID: "Jordan1"),ProductImageData(imagePID: "Jordan2")]
        
        return imageData
    }
    
    func getSlidesImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Slides"),ProductImageData(imagePID: "Slides1"),ProductImageData(imagePID: "Slides2")]
        
        return imageData
    }
    
    func getSandlesImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Sandles"),ProductImageData(imagePID: "Sandles1"),ProductImageData(imagePID: "Sandles2")]
        
        return imageData
    }
    
    func getDieselImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Diesel"),ProductImageData(imagePID: "Diesel1"),ProductImageData(imagePID: "Diesel2")]
        
        return imageData
    }
    
    func getMascaraImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Mascara"),ProductImageData(imagePID: "Mascara1"),ProductImageData(imagePID: "Mascara2")]
        
        return imageData
    }
    
    func getNailClipperImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "NailClipper"),ProductImageData(imagePID: "NailClipper1"),ProductImageData(imagePID: "NailClipper2")]
        
        return imageData
    }
    
    func getShampooImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Shampoo"),ProductImageData(imagePID: "Shampoo1"),ProductImageData(imagePID: "Shampoo2")]
        
        return imageData
    }
    
    func getConditionerImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Conditioner"),ProductImageData(imagePID: "Conditioner1"),ProductImageData(imagePID: "Conditioner2")]
        
        return imageData
    }
    
    func getFlaskImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Flask"),ProductImageData(imagePID: "Flask1"),ProductImageData(imagePID: "Flask2")]
        
        return imageData
    }
    
    func getDumbbellsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Dumbbells"),ProductImageData(imagePID: "Dumbbells1"),ProductImageData(imagePID: "Dumbbells2")]
        
        return imageData
    }
    
    func getResistanceBandsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "ResistanceBands"),ProductImageData(imagePID: "ResistanceBands1"),ProductImageData(imagePID: "ResistanceBands2")]
        
        return imageData
    }
    
    func getYogaMatImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "YogaMat"),ProductImageData(imagePID: "YogaMat1"),ProductImageData(imagePID: "YogaMat2")]
        
        return imageData
    }
    
    func getGymBagImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "GymBag"),ProductImageData(imagePID: "GymBag1"),ProductImageData(imagePID: "GymBag2")]
        
        return imageData
    }
    
    func getShirtImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Shirt"),ProductImageData(imagePID: "Shirt1"),ProductImageData(imagePID: "Shirt2")]
        
        return imageData
    }
    
    func getMLevisShortsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "MLevisShorts"),ProductImageData(imagePID: "MLevisShorts1"),ProductImageData(imagePID: "MLevisShorts2")]
        
        return imageData
    }
    
    func getMshortsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Mshorts"),ProductImageData(imagePID: "Mshorts1"),ProductImageData(imagePID: "Mshorts2")]
        
        return imageData
    }
    
    func getSweatshirtImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Sweatshirt"),ProductImageData(imagePID: "Sweatshirt1"),ProductImageData(imagePID: "Sweatshirt2")]
        
        return imageData
    }
    
    func getTshirtImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Tshirt"),ProductImageData(imagePID: "Tshirt1"),ProductImageData(imagePID: "Tshirt2")]
        
        return imageData
    }
    
    func getCardiganImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Cardigan"),ProductImageData(imagePID: "Cardigan1"),ProductImageData(imagePID: "Cardigan2")]
        
        return imageData
    }
    
    func getDressImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Dress"),ProductImageData(imagePID: "Dress1"),ProductImageData(imagePID: "Dress2")]
        
        return imageData
    }
    
    func getShortsImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Shorts"),ProductImageData(imagePID: "Shorts1"),ProductImageData(imagePID: "Shorts2")]
        
        return imageData
    }
    
    func getPulloverImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Pullover"),ProductImageData(imagePID: "Pullover1"),ProductImageData(imagePID: "Pullover2")]
        
        return imageData
    }
    
    func getJacketImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Jacket"),ProductImageData(imagePID: "Jacket1"),ProductImageData(imagePID: "Jacket2")]
        
        return imageData
    }
    
    func getlgImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "lg"),ProductImageData(imagePID: "lg1"),ProductImageData(imagePID: "lg2")]
        
        return imageData
    }
    
    func getSamsungImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Samsung"),ProductImageData(imagePID: "Samsung1"),ProductImageData(imagePID: "Samsung2")]
        
        return imageData
    }
    
    func getFrigidaireImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Frigidaire"),ProductImageData(imagePID: "Frigidaire1"),ProductImageData(imagePID: "Frigidaire2")]
        
        return imageData
    }
    
    func getTCLImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "TCL"),ProductImageData(imagePID: "TCL1"),ProductImageData(imagePID: "TCL2")]
        
        return imageData
    }
    
    func getGasImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Gas"),ProductImageData(imagePID: "Gas1"),ProductImageData(imagePID: "Gas2")]
        
        return imageData
    }
    
    func getSonyImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Sony"),ProductImageData(imagePID: "Sony1"),ProductImageData(imagePID: "Sony2")]
        
        return imageData
    }
    
    func getFujifilmImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Fujifilm"),ProductImageData(imagePID: "Fujifilm1"),ProductImageData(imagePID: "Fujifilm2")]
        
        return imageData
    }
    
    func getNintendoImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "Nintendo"),ProductImageData(imagePID: "Nintendo2"),ProductImageData(imagePID: "Nintendo2")]
        
        return imageData
    }
    
    func getRazerMouseImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "RazerMouse"),ProductImageData(imagePID: "RazerMouse1"),ProductImageData(imagePID: "RazerMouse2")]
        
        return imageData
    }
    
    func getRazerKeyboardImageData() -> [ProductImageData]
    {
        let imageData = [ProductImageData(imagePID: "RazerKeyboard"),ProductImageData(imagePID: "RazerKeyboard1"),ProductImageData(imagePID: "RazerKeyboard1")]
        
        return imageData
    }
}

