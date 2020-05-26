//
//  TitleModel.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

struct TitleModel {
    let title: String
    
    init(withTitle title: FlickrPhoto) {
        self.title = title.title
    }
}
