//
//  FlickrRequestConfig.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

enum FlickrRequestConfig {
    
    case searchRequest(String, Int, Int)
    
    var value: Request? {
        
        switch self {
            
        case .searchRequest(let searchText, let pageNo, let perAmount):
            let urlString = String(format: FlickrConstants.searchURL, searchText, pageNo, perAmount)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}
