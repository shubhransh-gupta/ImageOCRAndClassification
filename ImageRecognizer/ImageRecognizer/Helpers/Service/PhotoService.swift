//
//  PhotoService.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import Photos
import UIKit

class PhotoServices {

    
//    func fetchImages(OnSuccess : @escaping (UIImage?, String?) -> ()) {
//        DispatchQueue.main.async {
//            let fetchOptions = PHFetchOptions()
//            let imageManager = PHImageManager.default()
//
//            // Fetch all photos (you can customize the fetch options)
//            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//
//            // Iterate through the fetched assets and display them
//            fetchResult.enumerateObjects { (asset, _, _) in
//                let targetSize = CGSize(width: 1024, height: 1024) // Adjust the target size as needed
//                let requestOptions = PHImageRequestOptions()
//                requestOptions.isSynchronous = false
//                requestOptions.deliveryMode = .highQualityFormat
//
//                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
//                    if let image = image {
//                        // Display the fetched image (you can add it to a collection view, image view, etc.)
//                        // Example: self.imageView.image = image
//                        if let fileName = (info?["PHImageFileURLKey"] as? URL)?.lastPathComponent {
//                            // "fileName" now contains the name of the image file
//                            print("Image Name: \(fileName)")
//                            OnSuccess(image,fileName)
//                        }
//                        OnSuccess(image,"")
//                    }
//                }
//            }
//        }
//    }
    
}

//Extension to process batch request
extension PhotoServices {
    
    func fetchThumbnailForAsset(_ asset: PHAsset, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        // Create image request options
        let backgroundQueue = DispatchQueue.global(qos: .utility)
        
        backgroundQueue.async {
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = false
            requestOptions.deliveryMode = .fastFormat // Fastest delivery mode for thumbnails
            
            // Request the thumbnail
            PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: requestOptions, resultHandler: { image, _ in
                DispatchQueue.main.async {
                    completion(image)
                }
            })
        }
    }
    
}
