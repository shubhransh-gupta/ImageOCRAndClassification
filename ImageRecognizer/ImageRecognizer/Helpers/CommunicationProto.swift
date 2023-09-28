//
//  CommunicationProto.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import Foundation

protocol DataTransferDelegate : AnyObject {
    func didReceiveData(data : String)
}
