//
//  UITestViewController.swift
//  Pick&PayStore
//
//  Created   on 2022-07-03.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation

class UITestViewController: UIViewController {
    static var productIds = [NSNumber]()
    var productData = [Product]()
    var productReviews = [Review]()
    
    static var vc = UITestViewController()
    var productAtRow: Int64?
    static let cartBannerNotification = Notification.Name("cartBanner")
    @IBOutlet weak var cartBannerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        productData = []
        productReviews = []
        if UITestViewController.productIds.count != 0{
            for id in UITestViewController.productIds{
                let product = ProductsService.productsServiceInstance.getOneProduct(id: Int64(id))
                productData.append(product)
            }
            
            for i in 0..<productData[0].reviews!.count {
                let review = ReviewService.reviewServiceInstance.getReview(reviewId: Int64(productData[0].reviews![i]))
                productReviews.append(review)
            }
            
            let cart = CartService.cartServiceInstance.getCart()
            print(productReviews.count)
            // ProductsService.productsServiceInstance.updateProductStock(id: 1, amount: 3)
            print(cart.items!, cart.quantity!, cart.lastUpdated!)
            for product in productData {
                print(product.quantity)
            }
        } else {
            productData = ProductsService.productsServiceInstance.getData()
        }
        
        tableView.reloadData()
        view.addSubview(cartBannerView)
        cartBannerView.removeFromSuperview()
        NotificationCenter.default.addObserver(self, selector: #selector(self.onNotification(notification:)), name: UITestViewController.cartBannerNotification, object: nil)
    }

}

//MARK: CONFIGURE CART BANNER
extension UITestViewController {
    @objc func onNotification(notification: Notification) {
        

        
        
        cartBannerView.layer.cornerRadius = 20
        cartBannerView.layer.maskedCorners = [.layerMaxXMaxYCorner] //bottom right
        cartBannerView.layer.maskedCorners = [.layerMinXMaxYCorner] //bottom left
        cartBannerView.layer.maskedCorners = [.layerMaxXMinYCorner] //top right
        cartBannerView.layer.maskedCorners = [.layerMinXMinYCorner] //top left
        
        cartBannerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        cartBannerView.layer.masksToBounds = true
        cartBannerView.alpha = 0.0
        view.addSubview(cartBannerView)
        UIView.animate(withDuration: 0.75) { () -> Void in
            self.cartBannerView.alpha = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.75) { () -> Void in
                self.cartBannerView.alpha = 0.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.cartBannerView.removeFromSuperview()
            }
            
        }
    }
}

extension UITestViewController : UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITestTableViewCell
        cell.selectionStyle = .none
        
        let model = productData[indexPath.row]
        let viewModel = TestProductsViewModel(name: model.name!, price: model.price, image: model.image!, id: model.id)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    // barcode
    
  //var captureSession: AVCaptureSession!
    //var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    //location
    
   
   

//    class ViewController: UIViewController, CLLocationManagerDelegate {
//        let locationManager = CLLocationManager()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            locationManager.requestAlwaysAuthorization()
//            locationManager.requestWhenInUseAuthorization()
//            if CLLocationManager.locationServicesEnabled() {
//                locationManager.delegate = self
//                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//                locationManager.startUpdatingLocation()
//            }
//        }
//
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//            print("locations = \(locValue.latitude) \(locValue.longitude)")
//        }
//    }
    
    //Search Bar
    
    
    //
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    ////        filteredData = []
    //
    //        if (searchText == ""){
    ////            noteObject = filteredData
    //            arrayObject = NoteDBHelp.dbHelper.getAllUserNotes(searchParameter: UserSingleton.userData.currentUsername)
    //        } else{
    ////            for searchedbar in arrayObject{
    ////                if searchedbar.title.lowercased().contains(searchText.lowercased()){
    ////                    filteredData.append(searchedbar)
    ////                }
    //
    //            arrayObject = NoteDBHelp.dbHelper.searchNote(searchParameter: searchText.lowercased())
    //
    //        }
    //
    //        self.tableView.reloadData()
    //
    //    }
    //    scanning barsc
    
}
