//
//  VisionServices.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//
import Vision
import UIKit


class VisionServices {
    weak var commsDelegate : DataTransferDelegate?
    
    func performOCR(_ image: UIImage) {
        var localResult = ""
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
                    localResult += recognizedText
                }
            }
            self.updateDataModelWithOCRText(localResult)
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, orientation: .up)
        try? requestHandler.perform([textRecognitionRequest])
    }
    
    func updateDataModelWithOCRText(_ text: String) {
        if let delegate = commsDelegate {
            delegate.didReceiveData(data: text)
        }
    }
    
}
