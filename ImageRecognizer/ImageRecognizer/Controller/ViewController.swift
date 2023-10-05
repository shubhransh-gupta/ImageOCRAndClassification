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
    var childViewController : DetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    let photoManager = PhotoManager()
    var startIndex = 0
    var windowSize = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.photoManager.dataDelegate = self
        addGestureOnImageView()
        self.fetchImageFromPhotos()
        self.registerCollectionView()
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
        view.backgroundColor = UIColor.white
        scrollView.contentSize = contentView.bounds.size
        scrollView.layer.cornerRadius = 10
        scrollView.isScrollEnabled = false
        scrollView.delegate = self
        setUpScrollableView()
    }
    
    func addGestureOnImageView() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeftGesture.direction = .left
        currentImageView.addGestureRecognizer(swipeLeftGesture)
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRightGesture.direction = .right
        currentImageView.addGestureRecognizer(swipeRightGesture)
        currentImageView.isUserInteractionEnabled = true
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
        self.fetchPreviewImagesForAnyIndexClicked(index: currentIndex ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == self.images.count - 1 {
            self.photoManager.fetchThumbnailsForSlidingWindow(slidingWindowLength: windowSize, startingIndex : indexPath.item)
        }
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
        
        childViewController.currentImage = self.currentImageView.image
        childViewController.imageName = self.imageName[currentIndex ?? 0]
        present(childViewController, animated: true)
    }
    
    func removeFromScrollView() {
        dismiss(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let thresholdY: CGFloat = self.view.frame.height // Adjust this threshold as needed
            // Portrait orientation
            let yOffset = scrollView.contentOffset.y

            if yOffset > 0 { // User is scrolling down
                // Show the additional view and adjust its frame
                addChildViewControllerToScrollView()
            } else { // User is scrolling up
                // Hide the additional view
                removeFromScrollView()
            }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            // Handle the left swipe
            if self.currentIndex != 0 {
                self.currentIndex! -= 1
                self.fetchPreviewImages(isLeftSwipe: true)
            }
        } else if gesture.direction == .right {
            // Handle the right swipe
            self.currentIndex! += 1
            self.fetchPreviewImages(isLeftSwipe: false)
        }
    }
    
}
