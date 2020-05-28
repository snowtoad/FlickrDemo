//
//  UIButton+Extension.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/27.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func imageOutlined(_ image: UIImage = #imageLiteral(resourceName: "favorite_outlined"), color: UIColor = UIColor.orange) {
        let image = image.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.tintColor = color
    }
    
    func imageFilled(_ image: UIImage = #imageLiteral(resourceName: "favorite_filled"), color: UIColor = UIColor.orange) {
        let image = image.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.tintColor = color
    }

}
