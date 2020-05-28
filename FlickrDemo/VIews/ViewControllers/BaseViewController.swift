//
//  BaseViewController.swift
//  Flickr Demo
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreData

class BaseViewController: UIViewController {
    
   var viewModel = FlickrViewModel()
   var numberOfColumns: CGFloat = FlickrConstants.defaultColumnCount
   var numberOfRows: CGFloat = FlickrConstants.defaultRowCount
    
    let persistenceManager = PersistenceManager.shared
    
    var favoriteArray = [Favorite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
