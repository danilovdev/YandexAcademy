//
//  GalleryCell.swift
//  Notes
//
//  Created by Alexey Danilov on 7/21/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    var galleryImage: UIImage? {
        didSet {
            galleryImageView.image = galleryImage
        }
    }
    
    @IBOutlet weak var galleryImageView: UIImageView! {
        didSet {
            galleryImageView.contentMode = .scaleAspectFill
            galleryImageView.clipsToBounds = true
        }
    }

    @IBOutlet weak var imageContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
    }

}
