//
//  CommunicationProto.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import Foundation
import UIKit

protocol DataTransferDelegate : AnyObject {
    func didReceiveData(data : String)
}

protocol PhotosDataTransferComunicationaDelegate : AnyObject {
    func didReceiveThumbnails(photos : [UIImage])
    func didReceiveOriginalImage(image : UIImage, imageInfo : String)
}



