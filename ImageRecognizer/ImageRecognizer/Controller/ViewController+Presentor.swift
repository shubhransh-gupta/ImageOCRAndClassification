//
//  ViewController+Presentor.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import Foundation
import Photos
import UIKit

extension ViewController {
    
    func loadImagesFromGallery(OnSuccess : @escaping () -> (), OnPermissionDenied : @escaping (String) -> ()) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                // Permission granted, proceed to fetch images
                print("Access given")
                PhotoServices().fetchImagesWithNames(OnSuccess: { images, name in
                    if let image = images {
                        self.images.append(image)
                    }
                    if let name = name {
                        self.imageName.append(name)
                    }
                    OnSuccess()
                })
                
            case .denied, .restricted:
                // Permission denied, handle accordingly
                print("Access to photos is denied or restricted.")
                OnPermissionDenied("Access to photos is denied or restricted.")
            case .notDetermined:
                // Permission not determined, handle accordingly (you can request again)
                print("Permission not determined.")
                OnPermissionDenied("Permission not determined.")
            case .limited:
                print("Permission is limited.")
            @unknown default:
                break
            }
        }
    }
    
    func fetchImageFromPhotos() {
        self.loadImagesFromGallery(OnSuccess : {
            DispatchQueue.main.async {
                self.previewCollectionView.reloadData()
            }
        }) { error in
            print(error)
        }
    }
    
    
}

extension ViewController {
    
    func setBottomTabBar() {
        
        if let tab1 = Bundle.main.loadNibNamed("BottomBarViewsTableViewCell", owner: nil)?.first as? BottomBarViewsTableViewCell {
            tab1.logoImage.image = UIImage(systemName: "square.and.arrow.up")
            tab1.logoImage.tintColor = UIColor.systemBlue // Set the tint color
            tab1.logoImage.contentMode = .scaleAspectFit // Adjust content mode for sizing
            tab1.logoImage.frame.size = CGSize(width: 30, height: 30)
            tab1.labelName.text = "Share"
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sharePic(_:)))
            tapGesture.numberOfTapsRequired = 1
            tapGesture.numberOfTouchesRequired = 1
            tab1.addGestureRecognizer(tapGesture)
            bottomBar.addArrangedSubview(tab1)
        }
        
        if let tab2 = Bundle.main.loadNibNamed("BottomBarViewsTableViewCell", owner: nil)?.first as? BottomBarViewsTableViewCell {
            tab2.logoImage.image = UIImage(systemName: "info.circle")
            tab2.logoImage.tintColor = UIColor.systemBlue // Set the tint color
            tab2.logoImage.contentMode = .scaleAspectFit // Adjust content mode for sizing
            tab2.logoImage.frame.size = CGSize(width: 30, height: 30)
            tab2.labelName.text = "Info"
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(infoButtonPressed(_:)))
            tapGesture.numberOfTapsRequired = 1
            tapGesture.numberOfTouchesRequired = 1
            tab2.addGestureRecognizer(tapGesture)
            bottomBar.addArrangedSubview(tab2)
        }
        
        if let tab3 = Bundle.main.loadNibNamed("BottomBarViewsTableViewCell", owner: nil)?.first as? BottomBarViewsTableViewCell {
            tab3.logoImage.image = UIImage(systemName: "bin.xmark.fill")
            tab3.logoImage.tintColor = UIColor.systemBlue // Set the tint color
            tab3.logoImage.contentMode = .scaleAspectFit // Adjust content mode for sizing
            tab3.logoImage.frame.size = CGSize(width: 30, height: 30)
            tab3.labelName.text = "Delete"
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deletePic(_:)))
            tapGesture.numberOfTapsRequired = 1
            tapGesture.numberOfTouchesRequired = 1
            tab3.addGestureRecognizer(tapGesture)
            bottomBar.addArrangedSubview(tab3)
        }
        
        self.bottomBar.spacing = 5 // Set the spacing between views
        self.bottomBar.alpha = 1
        self.bottomBar.axis = .horizontal
        self.bottomBar.alignment = .fill
        self.bottomBar.distribution = .fillEqually
    }
    
}

extension ViewController {
    @objc func sharePic(_ sender: UITapGestureRecognizer) {
        let activityViewController = UIActivityViewController(activityItems: [images[currentIndex ?? 0]], applicationActivities: nil)
        // Present the UIActivityViewController
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.previewCollectionView.frame.midX, y: self.previewCollectionView.frame.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func deletePic(_ sender: UITapGestureRecognizer) {
        self.images[currentIndex ?? 0] = UIImage(named: "defaultIcon")!
        DispatchQueue.main.async {
            self.previewCollectionView.reloadData()
            self.currentImageView.image = UIImage(named: "defaultIcon")
        }
    }
    
    @objc func infoButtonPressed(_ sender: UITapGestureRecognizer) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.currentImage = self.currentImageView.image
        vc.imageName = self.imageName[currentIndex ?? 0]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    
        if UIDevice.current.orientation.isPortrait {
            // Portrait orientation
            scrollView.isScrollEnabled = false
        } else {
            // Landscape orientation
            scrollView.isScrollEnabled = true
            centerViewsInLandscape()
        }
//        self.setUpScrollableView()
    }
    
    func centerViewsInLandscape() {
        // Center containerView horizontally and vertically
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
        // Center subView within containerView horizontally and vertically
        currentImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        currentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

}
