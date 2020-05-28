//
//  TabBarViewController.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    static let identifier = "TabBarController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var controllers = [UIViewController]()
    
        let featuredVC = storyboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! UINavigationController
        let tabFeaturedBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        featuredVC.tabBarItem = tabFeaturedBarItem
                
        let favoriteVC = storyboard.instantiateViewController(withIdentifier: FavoriteViewController.identifier) as! UINavigationController
        let tabfavoriteBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favoriteVC.tabBarItem = tabfavoriteBarItem
        
        let tabBarList = [featuredVC, favoriteVC]
                    
        controllers.append(contentsOf: tabBarList)
        
        self.viewControllers = controllers
        
    }

}
