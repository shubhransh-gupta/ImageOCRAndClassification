//
//  VisionServices.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//
import Vision
import UIKit

class VisionServices {
    func performOCR(_ image: UIImage) {
        let textRecognitionRequest = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("OCR Error: \(error.localizedDescription)")
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return
            }
            
            for observation in observations {
                if let recognizedText = observation.topCandidates(1).first?.string {
                    // Extracted text from OCR
                    print("OCR Text: \(recognizedText)")
                    
                    // Update your app's data model with the extracted text
                    self.updateDataModelWithOCRText(recognizedText)
                }
            }
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, orientation: .up)
        try? requestHandler.perform([textRecognitionRequest])
    }
    
    func updateDataModelWithOCRText(_ text: String) {
        // Implement logic to update your app's data model with the extracted text
    }
    
}
