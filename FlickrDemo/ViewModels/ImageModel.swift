//
//  ImageModel.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

struct ImageModel {
    let imageURL: String
    
    init(withPhotos photo: FlickrPhoto) {
        self.imageURL = photo.imageURL
    }
}
