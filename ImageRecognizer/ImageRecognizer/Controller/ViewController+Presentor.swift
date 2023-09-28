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
                PhotoServices().fetchImages(OnSuccess: { images in
                    if let image = images {
                        self.images.append(image)
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
            bottomBar.addArrangedSubview(tab1)
        }
        
        if let tab2 = Bundle.main.loadNibNamed("BottomBarViewsTableViewCell", owner: nil)?.first as? BottomBarViewsTableViewCell {
            tab2.logoImage.image = UIImage(systemName: "info.circle")
            tab2.logoImage.tintColor = UIColor.systemBlue // Set the tint color
            tab2.logoImage.contentMode = .scaleAspectFit // Adjust content mode for sizing
            tab2.logoImage.frame.size = CGSize(width: 30, height: 30)
            tab2.labelName.text = "Info"
            bottomBar.addArrangedSubview(tab2)
        }
        
        if let tab3 = Bundle.main.loadNibNamed("BottomBarViewsTableViewCell", owner: nil)?.first as? BottomBarViewsTableViewCell {
            tab3.logoImage.image = UIImage(systemName: "bin.xmark.fill")
            tab3.logoImage.tintColor = UIColor.systemBlue // Set the tint color
            tab3.logoImage.contentMode = .scaleAspectFit // Adjust content mode for sizing
            tab3.logoImage.frame.size = CGSize(width: 30, height: 30)
            tab3.labelName.text = "Delete"
            bottomBar.addArrangedSubview(tab3)
        }
        
        self.bottomBar.spacing = 5 // Set the spacing between views
        self.bottomBar.alpha = 1
        self.bottomBar.axis = .horizontal
        self.bottomBar.alignment = .fill
        self.bottomBar.distribution = .fillEqually
    }
    
}
