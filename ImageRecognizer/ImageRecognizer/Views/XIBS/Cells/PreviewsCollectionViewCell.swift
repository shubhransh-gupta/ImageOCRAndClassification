//
//  PreviewsCollectionViewCell.swift
//  ImageRecognizer
//
//  Created by Shubhransh Gupta on 28/09/23.
//

import UIKit

class PreviewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var previewCells: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.previewCells.image = nil
    }

}

