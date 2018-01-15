//
//  FavoritesBar.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 11/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class FavouritesBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceHorizontal = true
        cv.backgroundColor = .brown
        return cv
    }()
    
    let favouriteCellId = "favouriteCellId"
    let width: CGFloat = 90
    let items: CGFloat = 0
    var favourites: [VoicelynContact]?
    
    var delegate: ContactsViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        addSubview(collectionView)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCollectionView() {
//        collectionView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: items * width, height: 0)
//        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: favouriteCellId)
    }
    
    
    //MARK: - Collection Delegate/Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favouriteCellId, for: indexPath) as! FavouriteCell
        cell.delegate = delegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 140)
    }
    
    //MARK: - FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        print("Content: ", collectionView.contentInset)
        print("Offset: ", collectionView.contentOffset)
        print("Scroll: ", collectionView.scrollIndicatorInsets)
        if #available(iOS 11.0, *) {
            print("Safe: ", collectionView.safeAreaInsets)
        } else {
            // Fallback on earlier versions
        }


        let totalWidth = items * width
        let left = (self.frame.width / 2) - (totalWidth / 2)
        
        if totalWidth < self.frame.width {
            return UIEdgeInsetsMake(0, left, 0, left)
        }
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}


