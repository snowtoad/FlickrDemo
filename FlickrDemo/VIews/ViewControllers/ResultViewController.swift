//
//  ResultViewController.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "ResultViewController"
    var content = ""
    var amount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        viewModelClosures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GCD.runOnMainThread {
            self.collectionView.reloadData()
        }
        
    }

    private func configureUI() {
        self.title = "搜尋結果 \(content)"
        collectionView.register(nib: ImageCollectionViewCell.nibName)
    }
}

//MARK:- Clousers
extension ResultViewController {
    
    fileprivate func viewModelClosures() {
        
        viewModel.search(text: content.urlEncoded(), amount: amount) {
            print("search completed.")
        }
        
        viewModel.dataUpdated = { [weak self] in
            print("data source updated")
            GCD.runOnMainThread {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func loadNextPage() {
        viewModel.fetchNextPage {
            print("next page fetched")
        }
    }
}

extension ResultViewController: ImageDelegate {
    func dataUpdated(index: Int) {
        if viewModel.isFavoriteArray[index] {
            PersistenceManager.shared.deleteFlickrPhoto(viewModel.photoArray[index])
        } else {
            PersistenceManager.shared.insertFavoriteInfo(viewModel.photoArray[index])
        }
        GCD.runOnMainThread {
            self.collectionView.reloadData()
        }
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = nil
        cell.delegate = self
        
        let model = viewModel.photoArray[indexPath.row]
        PersistenceManager.shared.checkIsFavorite(model) { (isSame) in
            if isSame {
                self.viewModel.isFavoriteArray[indexPath.row] = true
            } else {
                self.viewModel.isFavoriteArray[indexPath.row] = false
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell else {
            return
        }
        
        let model = viewModel.photoArray[indexPath.row]
        cell.configure(Model.init(withPhotos: model))
        
        cell.favoriteButton.tag = indexPath.row
        
        PersistenceManager.shared.checkIsFavorite(model) { (isSame) in
            if isSame {
                cell.favoriteButton.imageFilled()
            } else {
                cell.favoriteButton.imageOutlined()
            }
        }
        
        if indexPath.row == (viewModel.photoArray.count - 1) {
            loadNextPage()
        }
    }
    
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30) / numberOfColumns, height: (collectionView.bounds.height - 30) / numberOfRows)
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

