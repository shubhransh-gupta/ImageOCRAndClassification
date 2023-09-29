//
//  CategoryTableViewCell.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 29/09/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stackView.spacing = 4 // Set the spacing between views
        self.stackView.alpha = 1
        self.stackView.axis = .horizontal
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
        self.backgroundColor = .white
        self.title.textColor  = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editCTA(_ sender: Any) {
        
    }
    
    func appendValuesInStackView(value : String) {
        let tab = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        tab.text = value
        tab.textColor = .gray
        tab.textAlignment = .center
        tab.layer.cornerRadius = 10
        tab.layer.backgroundColor = UIColor.yellow.cgColor
        tab.layer.borderWidth = 1
        self.stackView.addArrangedSubview(tab)
    }
}
