//
//  FlickrViewModel.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FlickrViewModel: NSObject {

    private(set) var photoArray = [FlickrPhoto]()
    private var searchText = ""
    private var perAmount = 0
    private var pageNo = 1
    private var totalPageNo = 1
    
    var isFavoriteArray = [Bool]()
    
    var showAlert: ((String) -> Void)?
    var dataUpdated: (() -> Void)?
    
    func search(text: String, amount: Int, completion:@escaping () -> Void) {
        searchText = text
        perAmount = amount
        photoArray.removeAll()
        fetchResults(completion: completion)
    }
    
    private func fetchResults(completion:@escaping () -> Void) {
        
        guard #available(iOS 13.0, *) else {
            return UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        FlickrSearchService().request(searchText, pageNo: pageNo, perAmount: perAmount) { (result) in
        
            GCD.runOnMainThread {
            
                guard #available(iOS 13.0, *) else {
                    return UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
                
                switch result {
                case .Success(let results):
                    if let result = results {
                        self.totalPageNo = result.pages
                        self.photoArray.append(contentsOf: result.photo)
                        for _ in 0..<result.photo.count{
                            self.isFavoriteArray.append(false)
                        }
                        self.dataUpdated?()
                    }
                    completion()
                case .Failure(let message):
                    self.showAlert?(message)
                    completion()
                case .Error(let error):
                    if self.pageNo > 1 {
                        self.showAlert?(error)
                    }
                    completion()
                }
            }
        }
    }
    
    func fetchNextPage(completion:@escaping () -> Void) {
        if pageNo < totalPageNo {
            pageNo += 1
            fetchResults {
                completion()
            }
        } else {
            completion()
        }
    }
}
