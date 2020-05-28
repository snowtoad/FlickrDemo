//
//  FavoriteTableViewCell.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/27.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

protocol FavoriteDelegate: class {
    func dataUpdated(index: Int)
}

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton! {
        didSet {
            removeButton.imageFilled(#imageLiteral(resourceName: "remove"), color: .red)
            removeButton.addTarget(self, action: #selector(self.didSelected(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var label: UILabel!
    
    static let nibName = "FavoriteCollectionViewCell"
    
    weak var delegate: FavoriteDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @objc func didSelected(_ sender: UIButton) {
        delegate?.dataUpdated(index: sender.tag)
    }
    
    var favoriteModel: FavoriteModel? {
        didSet {
            if let favoriteModel = favoriteModel {
                imageView.image = #imageLiteral(resourceName: "placeholder")
                imageView.downloadImage(favoriteModel.imageURL)
                
                label.text = favoriteModel.title
            }
        }
    }
    
}
