//
//  HomeCarouselViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/17/22.
//

import UIKit

class HomeCarouselViewController: UIViewController {

    let carouselImages: [String] = [
        "homeScreenCarouselImage1",
        "homeScreenCarouselImage2",
        "homeScreenCarouselImage3",
        "homeScreenCarouselImage4"
    ]
    
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var pageControlCarousel: UIPageControl!
    @IBOutlet weak var collectionViewCarousel: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControlCarousel.numberOfPages = carouselImages.count
        pageControlCarousel.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeCarouselImages), userInfo: nil, repeats: true)
        }
    }
}

extension HomeCarouselViewController {
    @objc func changeCarouselImages() {
        if counter < carouselImages.count {
            let indexPath = IndexPath.init(item: counter, section: 0)
            let rect = self.collectionViewCarousel.layoutAttributesForItem(at: indexPath)?.frame
            collectionViewCarousel.scrollRectToVisible(rect!, animated: true)
            pageControlCarousel.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let indexPath = IndexPath.init(item: counter, section: 0)
            let rect = self.collectionViewCarousel.layoutAttributesForItem(at: indexPath)?.frame
            collectionViewCarousel.scrollRectToVisible(rect!, animated: true)
            pageControlCarousel.currentPage = counter
            counter = 1
        }
    }
}

extension HomeCarouselViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carouselImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselHome", for: indexPath) as! HomeCarouselCollectionViewCell
        cell.imageCarousel.image = UIImage(named: carouselImages[indexPath.row])
        return cell
    }
    
    
}
