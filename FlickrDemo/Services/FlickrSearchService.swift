//
//  FlickrSearchService.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FlickrSearchService: NSObject {
    
    /// Flickr API Call using the "flickr.photos.search" method, to retrieve photos based on search text from a given page
    ///
    /// - Parameters:
    ///   - text: search term
    ///   - page: which page
    ///   - completion: completion handler to retrieve result
    func request(_ searchText: String, pageNo: Int, perAmount: Int, completion: @escaping (Result<Photos?>) -> Void) {
        
        guard let request = FlickrRequestConfig.searchRequest(searchText, pageNo, perAmount).value else {
            return
        }
        
        NetworkManager.shared.request(request) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if let stat = model.stat, stat.uppercased().contains("OK") {
                        return completion(.Success(model.photos))
                    } else {
                        return completion(.Failure(NetworkManager.errorMessage))
                    }
                } else {
                    return completion(.Failure(NetworkManager.errorMessage))
                }
            case .Failure(let message):
                return completion(.Failure(message))
            case .Error(let error):
                return completion(.Failure(error))
            }
        }
    }
    
    func processResponse(_ data: Data) -> FlickrSearchResults? {
        do {
            let responseModel = try JSONDecoder().decode(FlickrSearchResults.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}
