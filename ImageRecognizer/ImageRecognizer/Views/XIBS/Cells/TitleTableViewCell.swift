//
//  TitleTableViewCell.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 29/09/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Create a CAShapeLayer for the cell's border
        let borderLayer = CAShapeLayer()
        borderLayer.frame = bounds
        borderLayer.cornerRadius = 6 // Set the corner radius to your desired value
        borderLayer.borderWidth = 1.0 // Set the border width
        borderLayer.borderColor = UIColor.black.cgColor // Set the border color
        
        // Apply the border to the cell's layer
        layer.addSublayer(borderLayer)
        
        // Make sure the content of the cell is not obscured by the border
        contentView.frame = bounds
    }
    
}
