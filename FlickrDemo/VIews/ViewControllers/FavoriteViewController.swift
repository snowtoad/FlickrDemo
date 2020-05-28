//
//  FavoriteViewController.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "FavoriteViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
    
    private func configureUI() {
        self.navigationItem.title = "我的最愛"
        collectionView.register(nib: FavoriteCollectionViewCell.nibName)
    }

}

//MARK:- Clousers
extension FavoriteViewController {
    
    fileprivate func getFavorites() {
        favoriteArray = PersistenceManager.shared.getFavoriteInfo()
        self.collectionView.reloadData()
    }

}

extension FavoriteViewController: FavoriteDelegate {
    func dataUpdated(index: Int) {
        PersistenceManager.shared.deleteFavoriteInfo(favoriteArray[index])
        getFavorites()
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.nibName, for: indexPath) as! FavoriteCollectionViewCell
        cell.imageView.image = nil
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FavoriteCollectionViewCell else {
            return
        }
        
        let model = favoriteArray[indexPath.row]
        cell.favoriteModel = FavoriteModel.init(withFavorites: model)
        
        cell.removeButton.tag = indexPath.row
        
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30)/numberOfColumns, height: (collectionView.bounds.height - 30)/numberOfRows)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}
