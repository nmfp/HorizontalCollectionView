//
//  FavoritesBar.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 11/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class FavouritesBar: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceHorizontal = true
        return cv
    }()
    
    let favouriteCellId = "favouriteCellId"
    
    var contactsViewController: ContactsViewController?
    
    override func setupViews() {
//        super.setupViews()
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: favouriteCellId)
    }

    
    //Mark: - Collection Delegate/Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favouriteCellId, for: indexPath) as! FavouriteCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 140)
    }
}


