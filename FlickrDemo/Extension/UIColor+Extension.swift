//
//  UIColorExtension.swift
//  Flickr Demo
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func rectImage(with: CGFloat, height: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: with, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let contectRef = UIGraphicsGetCurrentContext()
        contectRef?.setFillColor(self.cgColor)
        contectRef?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return img!
    }
    
    static let defaultColor: UIColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}
