//
//  DetailsViewController.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import UIKit
import Vision
import MLKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var currentImage : UIImage?
    var currentOCRData : String?
    var visionServices : VisionServices?
    var currentImagesTags : [ImageLabel] = []
    var imageName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 220
        visionServices = VisionServices()
        visionServices?.commsDelegate = self
        visionServices?.performOCR(currentImage ?? UIImage())
        getTagData()
        // Do any additional setup after loading the view.
    }


}

extension DetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 {
            if indexPath.row == 2 {
                if self.currentOCRData?.count ?? 0 > 200 {
                    return 400
                }
            }
            return 160
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.title.text = self.imageName
            cell.title.isUserInteractionEnabled = true
            cell.title.delegate = self
            cell.title.textColor = .black
            cell.title.backgroundColor = .white
            cell.title.layer.cornerRadius = 6
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
            cell.title.text = "Collections"
            if let tag1 = self.currentImagesTags.first?.text {
                cell.appendValuesInStackView(value:  "\(tag1)")
            }
            if let tag2 = self.currentImagesTags.last?.text {
                cell.appendValuesInStackView(value:  "\(tag2)")
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
            cell.title.text = "Description"
            cell.subtitle.text = self.currentOCRData
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("s")
        case 1:
            print("s")
        case 2:
            print("OCR Data")
            print(currentOCRData)
            
        default:
            print("do nothing")
        }
    }
    
}

extension DetailsViewController : DataTransferDelegate {
    
    func didReceiveData(data: String) {
        self.currentOCRData = data
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
        }
    }
    
    
}

extension DetailsViewController {
    func getTagData() {
        CoreMLServices().generateTagsFromImage(image: currentImage!, OnSuccess: { labels in
            
            for label in labels {
//                let labelText = label.text
//                let confidence = label.confidence
//                let index = label.index
                self.currentImagesTags.append(label)
            }
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            }
        })
    }
}

extension DetailsViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.imageName = textField.text ?? ""
    }
}
