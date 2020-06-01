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
    
    func configure(_ model: Model?) {
        guard let model = model else { return }
        //ImageView
        imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.downloadImage(model.imageURL)
        //Label
        label.text = model.title
    }

}
