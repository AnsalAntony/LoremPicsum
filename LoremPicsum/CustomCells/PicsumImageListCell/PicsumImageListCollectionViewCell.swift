//
//  PicsumImageListCollectionViewCell.swift
//  LoremPicsum
//
//  Created by Ansal Antony on 11/06/22.
//

import UIKit

class PicsumImageListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var showListImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.showListImage.layer.cornerRadius = 3
        self.showListImage.layer.masksToBounds = true
    }

}

