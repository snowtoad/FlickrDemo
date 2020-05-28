//
//  ImageCollectionViewCell.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

protocol ImageDelegate: class {
    func dataUpdated(index: Int)
}

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.imageOutlined()
            favoriteButton.addTarget(self, action: #selector(self.didSelected(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var label: UILabel!
    
    static let nibName = "ImageCollectionViewCell"
    
    var viewModel = FlickrViewModel()
    
    weak var delegate: ImageDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    @objc func didSelected(_ sender: UIButton) {
        delegate?.dataUpdated(index: sender.tag)
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
