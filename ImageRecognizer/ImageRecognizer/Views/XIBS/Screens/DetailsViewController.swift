//
//  DetailsViewController.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import UIKit
import Vision

class DetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var currentImage : UIImage?
    var currentOCRData : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        VisionServices().performOCR(currentImage ?? UIImage())
        // Do any additional setup after loading the view.
    }


}

extension DetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.title.text = ""
            cell.title.isUserInteractionEnabled = true
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
            cell.title.text = ""
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
            cell.title.text = ""
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


