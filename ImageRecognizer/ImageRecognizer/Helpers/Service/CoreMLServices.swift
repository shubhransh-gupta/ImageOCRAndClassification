//
//  CoreMLServices.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 29/09/23.
//

import UIKit
import CoreML
import Vision

class YourCoreMLModel {
    static func load() -> YourCoreMLModel? {
        do {
            let model = try ImageClassifier(configuration: MLModelConfiguration())
            return YourCoreMLModel(model: model)
        } catch {
            print("Error loading Core ML model: \(error)")
            return nil
        }
    }

    private let model: ImageClassifier

    private init(model: ImageClassifier) {
        self.model = model
    }

    func classify(image: UIImage) -> (name: String, tags: [String])? {
        guard let pixelBuffer = image.pixelBuffer() else {
            return nil
        }

        do {
            let input = ImageClassifierInput(image: pixelBuffer)
            let output = try model.prediction(input: input)

            // Extract the name and tags from the prediction
            let name = output.classLabel
            let tags = output.classLabelProbs.map { "\($0.key): \($0.value)" }

            return (name, tags)
        } catch {
            print("Error classifying image: \(error)")
            return nil
        }
    }
}
