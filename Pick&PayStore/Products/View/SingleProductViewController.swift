//
//  SingleProductViewController.swift
//  Pick&PayStore
//
//  Created by Sevag Gaprielian on 2022-07-14.
//

import UIKit
import MapKit

class SingleProductViewController: UIViewController {

    static var productId = Int64()
    static let cartBannerNotification = Notification.Name("cartBanner")
    static let vcForCartBanner = SingleProductViewController()
    var productIDForCartBanner: Int64?
    var productData = Product()
    var reviewData = [Review]()
    @IBOutlet weak var productStock: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var reviewText: UITextView!
    
    @IBOutlet weak var cartBannerContainer: UIView!
    @IBOutlet weak var addToCartButton: YellowButton!
    
    @IBOutlet weak var reviewTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        productData = ProductsService.productsServiceInstance.getOneProduct(id: SingleProductViewController.productId)
        productName.text = productData.name
        
        productImage.backgroundColor = .white
        productImage.image = UIImage(named: productData.image!)
//        productImage.layer.cornerRadius = 20
//        productImage.layer.borderColor = UIColor(named: "darkBlue")?.cgColor
//        productImage.layer.borderWidth = 4
        productPrice.text = "$" + String(productData.price)
        if productData.quantity != 0 {
            productStock.text = String(productData.quantity) + " items in stock"
            productStock.textColor = .systemTeal
        } else {
            productStock.text = "Sold Out"
            productStock.textColor = .red
        }
        
        if !productData.reviews!.isEmpty {
            for review in productData.reviews!{
                let fetchedReview = ReviewService.reviewServiceInstance.getReview(reviewId: Int64(review))
                reviewData.append(fetchedReview)
            }
        }
        
        reloadButtonForStock()
        
        viewWillAppear_configCartBanner()

    }
    
    func reloadButtonForStock(){
        if productData.quantity == 0 {
            addToCartButton.setTitle("Out of Stock", for: .normal)
            addToCartButton.tintColor = .lightGray
            addToCartButton.isUserInteractionEnabled = false
        } else {
            addToCartButton.setTitle("Add to Cart", for: .normal)
            addToCartButton.isUserInteractionEnabled = true
        }
    }

    @IBAction func addToCart(_ sender: Any) {
        CartService.cartServiceInstance.addUpdateItemToCart(itemId: SingleProductViewController.productId, quantity: 1)
        publish(productID: SingleProductViewController.productId)
        subscribe()
    }
   
    @IBAction func addReview(_ sender: Any) {
        ReviewService.reviewServiceInstance.addReview(text: reviewText.text, productID: Int(SingleProductViewController.productId))
        
        productData = ProductsService.productsServiceInstance.getOneProduct(id: SingleProductViewController.productId)
        
        reviewData = []
        
        for review in productData.reviews!{
            let fetchedReview = ReviewService.reviewServiceInstance.getReview(reviewId: Int64(review))
            reviewData.append(fetchedReview)
        }
        
        reviewTable.reloadData()
    }
    
}

extension SingleProductViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !reviewData.isEmpty {
            return reviewData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        cell.selectionStyle = .none

        if !reviewData.isEmpty {
            let model = reviewData[indexPath.row]
            let viewModel = ReviewViewModel(text: model.text!, date: model.date!)
            cell.configure(viewModel: viewModel)
        } else {
            cell.reviewText.text = "No Reviews found"
            cell.reviewDate.text = " "
        }
        
        return cell
    }
    
    
    
    
}

//MARK: CONFIGURE CART BANNER
extension SingleProductViewController {

    func viewWillAppear_configCartBanner() {
        view.addSubview(cartBannerContainer)
        cartBannerContainer.removeFromSuperview()
        NotificationCenter.default.addObserver(self, selector: #selector(subscribe(notification:)), name: SingleProductViewController.cartBannerNotification, object: nil)

    }
    func publish(productID: Int64) {
        SingleProductViewController.vcForCartBanner.productIDForCartBanner = productID
        NotificationCenter.default.post(name: SingleProductViewController.cartBannerNotification, object: nil)
        
    }
    
    func subscribe() {
        
        self.cartBannerContainer.layer.cornerRadius = 20
        self.cartBannerContainer.layer.maskedCorners = [.layerMaxXMaxYCorner] //bottom right
        self.cartBannerContainer.layer.maskedCorners = [.layerMinXMaxYCorner] //bottom left
        self.cartBannerContainer.layer.maskedCorners = [.layerMaxXMinYCorner] //top right
        self.cartBannerContainer.layer.maskedCorners = [.layerMinXMinYCorner] //top left

        self.cartBannerContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        self.cartBannerContainer.layer.masksToBounds = true
        self.cartBannerContainer.alpha = 0.0
        view.addSubview(cartBannerContainer)
        UIView.animate(withDuration: 0.75) { () -> Void in
            self.cartBannerContainer.alpha = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.75) { () -> Void in
                self.cartBannerContainer.alpha = 0.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.cartBannerContainer.removeFromSuperview()
            }

        }

    }
    @objc func subscribe(notification: Notification) {
        subscribe()
    }
}
