//
//  ViewController+Presentor.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import Foundation
import Photos

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
    
    private func setBottomTabBar() {
        
    }
    
}
