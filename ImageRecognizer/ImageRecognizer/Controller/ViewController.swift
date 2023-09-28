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
        setUpScrollableView()
    }
    
    func setUpScrollableView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // Add constraints for the content views within contentView
        ])
        
        scrollView.contentSize = contentView.bounds.size
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
