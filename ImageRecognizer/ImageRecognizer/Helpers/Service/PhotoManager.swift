//
//  PhotoManager.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 04/10/23.
//

import Photos
import UIKit

class PhotoManager {
    
    var allPHAssets : [PHAsset] = []
    var fetchedThumbnailImages: [UIImage] = []
    var previewRealImages : [UIImage?] = [UIImage?](repeating: nil, count: 10)
    var realImageInfo : [String] = [String](repeating: "", count: 10)
    
    weak var dataDelegate : PhotosDataTransferComunicationaDelegate?
    
    func processBatchRequestForPHAssets() {
        // Request authorization to access the photo library
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                // Handle authorization denial
                return
            }
            
            // Create fetch options to fetch all image assets
            let fetchOptions = PHFetchOptions()
            let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            
            // Populate the allAssets array with fetched assets
            assets.enumerateObjects { asset, _, _ in
                self.allPHAssets.append(asset)
            }
            
            // Call a function to fetch images for the first 15 assets
            self.fetchThumbnailsForSlidingWindow(slidingWindowLength: 11, startingIndex : 0)
        }
    }
    
    func fetchThumbnailsForSlidingWindow(slidingWindowLength : Int, startingIndex : Int) {
        let maxAssetsToFetch = min(self.allPHAssets.count, slidingWindowLength + startingIndex) // Ensure we don't go beyond the array size
        
        guard startingIndex < maxAssetsToFetch else {
            print("image assets are over")
            return
        }
        
        for index in startingIndex..<maxAssetsToFetch {
            let asset = self.allPHAssets[index]
            
            PhotoServices().fetchThumbnailForAsset(asset, targetSize: CGSize(width: 20, height: 20)) { thumbnailImage in
                if let thumbnailImage = thumbnailImage {
                    // Add the fetched image to the array
                    self.fetchedThumbnailImages.append(thumbnailImage)
                    
                    // Check if all images have been fetched
                    if self.fetchedThumbnailImages.count == maxAssetsToFetch - 1 {
                        // All images have been fetched
                        if let del = self.dataDelegate {
                            del.didReceiveThumbnails(photos: self.fetchedThumbnailImages)
                        }
                        
                    }
                } else {
                    print("the case where a thumbnail couldn't be retrieved")
                }
            }
        }
    }
    
}

//extension for fetching original Images
extension PhotoManager {
    
    func fetchPreviewImagesWithNames(startIndex : Int, endIndex : Int,OnSuccess : @escaping ([UIImage?], [String]) -> ())  {
        guard endIndex < self.allPHAssets.count, startIndex >= 0 else {
            print("processing out of scope images")
            return
        }
        
//        self.previewRealImages.removeAll()
//        self.realImageInfo.removeAll()
        
        for index in startIndex...endIndex {
            let asset = self.allPHAssets[index]
            let imageManager = PHImageManager.default()
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            imageManager.requestImageDataAndOrientation(for: asset, options: requestOptions) { data, _, _, info in
                if let data = data, let image = UIImage(data: data) {
                    // Get the file name from the asset's local identifier
                    let id = PHAssetResource.assetResources(for: asset).first?.assetLocalIdentifier
                    self.previewRealImages.insert(image, at: index)
                    self.realImageInfo.insert(id ?? "", at: index)
                    
                    if index == endIndex {
                        OnSuccess(self.previewRealImages, self.realImageInfo)
                    }
                    
                }
            }
        }
        
    }
    
    func fetchNextPreviewImageToDisplay(imageIndex : Int, evictionIndex : Int)  {
        guard imageIndex < self.allPHAssets.count else {
            print("images are over. need more data to read")
            return
        }
        //image to delete for preview
        self.previewRealImages.remove(at: evictionIndex)
        self.realImageInfo.remove(at: evictionIndex)
        
        let asset = self.allPHAssets[imageIndex]
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        imageManager.requestImageDataAndOrientation(for: asset, options: requestOptions) { data, _, _, info in
            if let data = data, let image = UIImage(data: data) {
                // Get the file name from the asset's local identifier
                let id = PHAssetResource.assetResources(for: asset).first?.assetLocalIdentifier
                self.previewRealImages.append(image)
                self.realImageInfo.append(id ?? "")
               
                if let del = self.dataDelegate {
                    del.didReceiveOriginalImage(image: image, imageInfo : id ?? "")
                }
                
            }
        }
    }
    
}
