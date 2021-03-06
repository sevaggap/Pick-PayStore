//
//  ProductsService.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-03.
//

import Foundation

class ProductsService {
    
    static var productsServiceInstance = ProductsService()
    
    func resetData(){
        ProductsHelper.productsHelper.resetProdcuts()
    }
    
    func addData(){
        ProductsHelper.productsHelper.addProduct(name: "Sony WH1000MX5", price: 499.99, quantity: 10, category: 1, image: "Sony", id:1)
        ProductsHelper.productsHelper.addProduct(name: "Nintendo Switch", price: 379.99, quantity: 10, category: 1, image: "Nintendo", id:2)
        ProductsHelper.productsHelper.addProduct(name: "Razer Basilisk X HyperSpeed Mouse", price: 79.99, quantity: 10, category: 1, image: "RazerMouse", id:3)
        ProductsHelper.productsHelper.addProduct(name: "FujiFilm Instax Mini 11", price: 99.99, quantity: 10, category: 1, image: "Fujifilm", id:4)
        ProductsHelper.productsHelper.addProduct(name: "Razer Cynosa V2 Gaming Keyboard", price: 79.99, quantity: 10, category: 1, image: "RazerKeyboard", id:5)

        ProductsHelper.productsHelper.addProduct(name: "LG French Door Refriderator 36 Width 27.9 cu ft Capacity", price: 2794.99, quantity: 10, category: 2, image: "lg", id: 6)
        ProductsHelper.productsHelper.addProduct(name: "Samsung -  Smart TV - 50 TU7000 4K Ultra HDR Smart TV", price: 648.99, quantity: 10, category: 2, image: "Samsung", id:7)
        ProductsHelper.productsHelper.addProduct(name: "Frigidaire EFIC108-Red Compact Ice Maker", price: 129.99, quantity: 10, category: 2, image: "Frigidaire", id:8)
        ProductsHelper.productsHelper.addProduct(name: "TCL  - Smart TV - 3 Series 32 1080p HD LED Roku Smart TV", price: 230.99, quantity: 10, category: 2, image: "TCL", id:9)
        ProductsHelper.productsHelper.addProduct(name: "Frigidaire Gas - FCRG3052AS Range Free Stading Gas Range 30", price: 994.99, quantity: 10, category: 2, image: "Gas", id:10)
        
        ProductsHelper.productsHelper.addProduct(name: "Women's Cozy Button Up Cardigan", price: 14.99, quantity: 10, category: 3, image: "Cardigan", id:11)
        ProductsHelper.productsHelper.addProduct(name: "Yellow Sun Dress", price: 29.99, quantity: 10, category: 3, image: "Dress", id:12)
        ProductsHelper.productsHelper.addProduct(name: "Levi's - 501 '90s Womens Shorts ", price: 88.99, quantity: 10, category: 3, image: "Shorts", id:13)
        ProductsHelper.productsHelper.addProduct(name: "Women's Knit Drop Shoulder Pullover", price: 19.99, quantity: 10, category: 3, image: "Pullover", id:14)
        ProductsHelper.productsHelper.addProduct(name: "Women's Zipper Front Biker Jacket", price: 39.99, quantity: 10, category: 3, image: "Jacket", id:15)
        
        ProductsHelper.productsHelper.addProduct(name: "Hawaiian Button Up Shirt", price: 16.99, quantity: 10, category: 4, image: "Shirt", id:16)
        ProductsHelper.productsHelper.addProduct(name: "Men's Tan Cargo  Shorts", price: 39.99, quantity: 10, category: 4, image: "Mshorts", id:17)
        ProductsHelper.productsHelper.addProduct(name: "Levi's - 505 Regular Fit Men Shorts", price: 49.99, quantity: 10, category: 4, image: "MLevisShorts", id:18)
        ProductsHelper.productsHelper.addProduct(name: "Men's Sweatshirt", price: 49.99, quantity: 10, category: 4, image: "Sweatshirt", id:19)
        ProductsHelper.productsHelper.addProduct(name: "Classic Cotton T-Shirt", price: 9.99, quantity: 10, category: 4, image: "Tshirt", id:20)

        ProductsHelper.productsHelper.addProduct(name: "Hydro Flask Water Bottle", price: 39.99, quantity: 10, category: 5, image: "Flask", id:21)
        ProductsHelper.productsHelper.addProduct(name: "25 LB Dumbbells ", price: 27.99, quantity: 10, category: 5, image: "Dumbbells", id:22)
        ProductsHelper.productsHelper.addProduct(name: "Resistance Bands", price: 9.99, quantity: 10, category: 5, image: "ResistanceBands", id:23)
        ProductsHelper.productsHelper.addProduct(name: "Yoga Mat", price: 35.99, quantity: 10, category: 5, image: "YogaMat", id:24)
        ProductsHelper.productsHelper.addProduct(name: "Gym Bag", price: 46.99, quantity: 10, category: 5, image: "GymBag", id:25)

        ProductsHelper.productsHelper.addProduct(name: "Diesel Protein Powder", price: 114.99, quantity: 10, category: 6, image: "Diesel", id:26)
        ProductsHelper.productsHelper.addProduct(name: "L'Oreal Paris - Voluminous Lash Paradise Mascara", price: 11.99, quantity: 10, category: 6, image: "Mascara", id:27)
        ProductsHelper.productsHelper.addProduct(name: "Nail Clippers", price: 10.99, quantity: 10, category: 6, image: "NailClipper", id:28)
        ProductsHelper.productsHelper.addProduct(name: "Head & Shoulders Shampoo", price: 8.99, quantity: 10, category: 6, image: "Shampoo", id:29)
        ProductsHelper.productsHelper.addProduct(name: "Head & Shoulders Conditioner", price: 8.99, quantity: 10, category: 6, image: "Conditioner", id:30)

        ProductsHelper.productsHelper.addProduct(name: "Black Crocs", price: 59.99, quantity: 10, category: 7, image: "Crocs", id:31)
        ProductsHelper.productsHelper.addProduct(name: "Tan Timberland Boots", price: 110.00, quantity: 10, category: 7, image: "Timberland", id:32)
        ProductsHelper.productsHelper.addProduct(name: "Nike Jordan 1 Mid Light Smoke Grey", price: 350.00, quantity: 10, category: 7, image: "Jordan", id:33)
        ProductsHelper.productsHelper.addProduct(name: "Nike Slides", price: 19.99, quantity: 10, category: 7, image: "Slides", id:34)
        ProductsHelper.productsHelper.addProduct(name: "Women's Tan Summer Sandles", price: 59.99, quantity: 10, category: 7, image: "Sandles", id:35)

        ProductsHelper.productsHelper.addProduct(name: "3 Piece Luggage Set", price: 139.99, quantity: 10, category: 8, image: "LuggageSet", id:36)
        ProductsHelper.productsHelper.addProduct(name: "Neck Pillow", price: 49.99, quantity: 10, category: 8, image: "Pillow", id:37)
        ProductsHelper.productsHelper.addProduct(name: "Fosmon Luggage Lock - 3 Piece", price: 22.99, quantity: 10, category: 8, image: "Lock", id:38)
        ProductsHelper.productsHelper.addProduct(name: "Passport Holder", price: 19.99, quantity: 10, category: 8, image: "Passport", id:39)
        ProductsHelper.productsHelper.addProduct(name: "Mini Handheld Fan", price: 26.99, quantity: 10, category: 8, image: "MiniFan", id:40)

        ProductsHelper.productsHelper.addProduct(name: "Kitchenaid Custom Stand Mixer - 4.5 QT - 325-Watt", price: 499.99, quantity: 10, category: 9, image: "Mixer", id:41)
        ProductsHelper.productsHelper.addProduct(name: "Kitchen Towels", price: 9.99, quantity: 10, category: 9, image: "Towels", id:42)
        ProductsHelper.productsHelper.addProduct(name: "56 Piece Cutlery Set", price: 59.99, quantity: 10, category: 9, image: "CutlerySet", id:43)
        ProductsHelper.productsHelper.addProduct(name: "18 Piece Dinnerware Set", price: 59.99, quantity: 10, category: 9, image: "Dinnerware", id:44)
        ProductsHelper.productsHelper.addProduct(name: "Clear Glass Set", price: 8.99, quantity: 10, category: 9, image: "GlassSet", id:45)

        ProductsHelper.productsHelper.addProduct(name: "White Fabric Right Sectional Sofa", price: 8.99, quantity: 10, category: 10, image: "Sofa", id:46)
        ProductsHelper.productsHelper.addProduct(name: "Footstoll with Storage", price: 8.99, quantity: 10, category: 10, image: "Footstooll", id:47)
        ProductsHelper.productsHelper.addProduct(name: "Tan Recliner", price: 8.99, quantity: 10, category: 10, image: "Recliner", id:48)
        ProductsHelper.productsHelper.addProduct(name: "Wodden Dinning Room Table Set", price: 8.99, quantity: 10, category: 10, image: "DiningSet", id:49)
        ProductsHelper.productsHelper.addProduct(name: "Coffee Table", price: 8.99, quantity: 10, category: 10, image: "CoffeTable", id:50)

        ProductsHelper.productsHelper.addProduct(name: "Jumbo Poly Leaf Rake", price: 19.99, quantity: 10, category: 11, image: "LeafRake", id:51)
        ProductsHelper.productsHelper.addProduct(name: "Garden Hose", price: 99.99, quantity: 10, category: 11, image: "GardenHose", id:52)
        ProductsHelper.productsHelper.addProduct(name: "Backyard Gazebo", price: 399.99, quantity: 10, category: 11, image: "Gazebo", id:53)
        ProductsHelper.productsHelper.addProduct(name: "Lawn Chair", price: 19.99, quantity: 10, category: 11, image: "LawnChair", id:54)
        ProductsHelper.productsHelper.addProduct(name: "Gas BBQ", price: 629.99, quantity: 10, category: 11, image: "BBQ", id:55)

        ProductsHelper.productsHelper.addProduct(name: "The Life of Pi By Yann Martel", price: 11.99, quantity: 10, category: 12, image: "LifeOfPi1", id:56)
        ProductsHelper.productsHelper.addProduct(name: "Milk and Honey By Rupi Kuar", price: 19.99, quantity: 10, category: 12, image: "MilkAndHoney1", id:57)
        ProductsHelper.productsHelper.addProduct(name: "The Hunger Games  By Suzanne Collins", price: 16.99, quantity: 10, category: 12, image: "HungerGames2", id:58)
        ProductsHelper.productsHelper.addProduct(name: "The City of Bones By Cassandra Clare", price: 16.99, quantity: 10, category: 12, image: "CityoOfBones2", id:59)
        ProductsHelper.productsHelper.addProduct(name: "The Fault in Our Stars By John Green", price: 14.99, quantity: 10, category: 12, image: "open-box", id:60)


    }
    
    func getData() -> [Product]{
        
        let products = ProductsHelper.productsHelper.getProducts()
        
        return products
    }
    
    func getOneProduct(id : Int64) -> Product {
        let product = ProductsHelper.productsHelper.getProduct(id: id)
        
        return product
    }
    
    func updateProductStock(id : Int64, amount : Int64){
        ProductsHelper.productsHelper.updateQuantity(id: id, amount: amount)
    }
}
