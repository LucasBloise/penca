//
//  BannerCollectionViewCell.swift
//  penca
//
//  Created by Lucas Bloise on 26/09/2022.
//

import UIKit
import Kingfisher
class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    static let identifier = "BannerCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure( imagerURL: String) {
        imageView.kf.setImage(with: URL(string: "https://\(imagerURL)"))
    }
}
