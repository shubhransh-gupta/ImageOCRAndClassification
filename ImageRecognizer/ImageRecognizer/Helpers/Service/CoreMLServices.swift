//
//  CoreMLServices.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 29/09/23.
//

import UIKit
import MLKit

class CoreMLServices {
    
    func generateTagsFromImage(image : UIImage, OnSuccess: @escaping ([ImageLabel]) -> ()) {
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        // to set the minimum confidence required:
        let options = ImageLabelerOptions()
        options.confidenceThreshold = 0.3
        let labeler = ImageLabeler.imageLabeler(options: options)
        labeler.process(visionImage) { labels, error in
            guard error == nil, let labels = labels else { return }
            print(labels)
            OnSuccess(labels)
        }
    }
}
