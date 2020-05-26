//
//  TextFieldModel.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

class TextFieldViewModel {
    func checkIsNotEmpty(_ name: String, _ perPage: String, completion: @escaping (Bool) -> Void, handler: @escaping (Bool) -> Void) {
        if name.isEmpty || perPage.isEmpty {
            completion(false)
        } else {
            guard Int(perPage) != nil else { return completion(false) }
            completion(true)
        }
        if Int(perPage) == 0 {
            completion(false)
            handler(true)
        } else {
            handler(false)
        }
    }
}
