//
//  TitleTableViewCell.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 29/09/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
