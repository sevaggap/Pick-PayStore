//
//  CarouselViewController.swift
//  Pick&PayStore
//
//  Created by Xavier on 7/17/22.
//

import UIKit

class CarouselViewController: UIViewController {

    let carouselImages: [String] = [
        "CoffeeTable",
        "CutlerySet",
        "DiningSet",
        "CityOfBones2",
        "CoffeeTable",
        "CutlerySet",
        "DiningSet"
    ]
    
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var pageControlCarousel: UIPageControl!
    @IBOutlet weak var collectionViewCarousel: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControlCarousel.numberOfPages = 7
        pageControlCarousel.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeCarouselImages2), userInfo: nil, repeats: true)
        }
    }
}

extension CarouselViewController {
    @objc func changeCarouselImages2() {
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


extension CarouselViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carouselImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell2", for: indexPath) as! CarouselCollectionViewCell
        cell.imageCarouselCell.image = UIImage(named: carouselImages[indexPath.row])
        return cell

    }
}

