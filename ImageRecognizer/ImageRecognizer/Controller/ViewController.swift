//
//  ViewController.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var previewCollectionView: UICollectionView!
    @IBOutlet weak var currentImageView: UIImageView!
    @IBOutlet weak var bottomBar: UIView!
    
    var images : [UIImage] = []
    
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
        previewCollectionView.dataSource = self
        previewCollectionView.delegate = self
    }
    
    private func setUI() {
        self.currentImageView.image = UIImage(named: "defaultIcon")
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
        currentImageView.image = images[indexPath.item]
    }


}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the cell size here
        let cellWidth: CGFloat = 80 // Set your desired width
        let cellHeight: CGFloat = 100 // Set your desired height
        print("Shubhransh Gupta")
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
