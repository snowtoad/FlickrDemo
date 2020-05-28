//
//  ComponentModel.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/27.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

struct FavoriteModel {
    let imageURL: String
    let title: String
    
    init(withFavorites favorite: Favorite) {
        var imageURL: String {
            let urlString = String(format: FlickrConstants.imageURL, favorite.farm, favorite.server!, favorite.id!, favorite.secret!)
            return urlString
        }
        self.imageURL = imageURL
        self.title = favorite.title ?? ""
    }
}
