//
//  ImageCollectionViewCell.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    static let nibName = "ImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    var model: ImageModel? {
        didSet {
            if let model = model {
                imageView.image = #imageLiteral(resourceName: "placeholder")
                imageView.downloadImage(model.imageURL)
            }
        }
    }
    
    var titleModel: TitleModel? {
        didSet {
            if let titleModel = titleModel {
                label.text = titleModel.title
            }
        }
    }

}
