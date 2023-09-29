//
//  ViewController.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var previewCollectionView: UICollectionView!
    @IBOutlet weak var currentImageView: UIImageView!
    @IBOutlet weak var bottomBar: UIStackView!
    
    var images : [UIImage] = []
    var currentIndex : Int? 
    var imageName : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.fetchImageFromPhotos()
        self.registerCollectionView()
        // Do any additional setup after loading the view.
    }


}

extension ViewController {
    
    private func registerCollectionView() {
        previewCollectionView.register(UINib(nibName: "PreviewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PreviewsCollectionViewCell")
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
    }
    
    private func setUI() {
        self.currentImageView.image = UIImage(named: "defaultIcon")
        self.setBottomTabBar()
        scrollView.contentSize = contentView.bounds.size
        scrollView.isScrollEnabled = false
        scrollView.delegate = self
        setUpScrollableView()
    }
    
    func setUpScrollableView() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            // Add constraints for the content views within contentView
        ])
        
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewsCollectionViewCell", for: indexPath) as! PreviewsCollectionViewCell
         cell.previewCells.image  = images[indexPath.item]
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.item
        currentImageView.image = images[indexPath.item]
    }


}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the cell size here
        let cellWidth: CGFloat = self.previewCollectionView.frame.size.width / 11 // Set your desired width
        let cellHeight: CGFloat = 100 // Set your desired height
        print("Shubhransh Gupta")
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension ViewController : UIScrollViewDelegate {
    func addChildViewControllerToScrollView() {
        let childViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        childViewController.currentImage = self.currentImageView.image
        childViewController.imageName = self.imageName[currentIndex ?? 0]
        addChild(childViewController)
        scrollView.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let thresholdY: CGFloat = self.view.frame.height // Adjust this threshold as needed

        if scrollView.contentOffset.y > thresholdY {
            // Add the child view controller when the user scrolls beyond the threshold
            addChildViewControllerToScrollView()
        }
    }
    
}
