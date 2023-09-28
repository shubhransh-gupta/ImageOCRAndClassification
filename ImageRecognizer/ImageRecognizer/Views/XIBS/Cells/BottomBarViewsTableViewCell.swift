//
//  BottomBarViewsTableViewCell.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import UIKit

class BottomBarViewsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
