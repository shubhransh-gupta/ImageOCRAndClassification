//
//  PhotoService.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import Photos
import UIKit

class PhotoServices {
    
    func fetchImages(OnSuccess : @escaping (UIImage?) -> ()) {
        DispatchQueue.main.async {
            let fetchOptions = PHFetchOptions()
            let imageManager = PHImageManager.default()
            
            // Fetch all photos (you can customize the fetch options)
            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            
            // Iterate through the fetched assets and display them
            fetchResult.enumerateObjects { (asset, _, _) in
                let targetSize = CGSize(width: 200, height: 200) // Adjust the target size as needed
                let requestOptions = PHImageRequestOptions()
                requestOptions.isSynchronous = false
                requestOptions.deliveryMode = .highQualityFormat
                
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        // Display the fetched image (you can add it to a collection view, image view, etc.)
                        // Example: self.imageView.image = image
                        OnSuccess(image)
                    }
                }
            }
        }
    }
}


