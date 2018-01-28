//
//  DropView.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 25/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

protocol ChangeDialerDelegate {
    func handleChangeDialerNumber(cell: VoicelynCell)
}

class DropView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var contactPerson: OwnerContact? {
        didSet {
            guard let contact = contactPerson else {return}
            allPhoneNumbersAvailable = contact.allMyNumbers.filter {$0.number != contact.numberInUse.number}
        }
    }
    
    var allPhoneNumbersAvailable = [CountryPhoneNumber]()
    
    var delegate: ChangeDialerDelegate?
    var lastIndexPathSelected: IndexPath?
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.allowsMultipleSelection = true
        cv.canCancelContentTouches = false
        cv.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        return cv
    }()
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            let startPoint = gesture.location(in: collectionView)
            guard let cellIndexPath = collectionView.indexPathForItem(at: startPoint) else {return}
            lastIndexPathSelected = cellIndexPath
        }
        else if gesture.state == .changed {
            let stopPoint = gesture.location(in: collectionView)
            guard let cellIndexPath = collectionView.indexPathForItem(at: stopPoint) else {return}
            guard let lastCellIndexPath = lastIndexPathSelected else {return}
            if cellIndexPath != lastCellIndexPath {
                let cellHighlighted = collectionView.cellForItem(at: cellIndexPath) as! VoicelynCell
                cellHighlighted.isHighlighted = true
                let cellUnlighted = collectionView.cellForItem(at: lastCellIndexPath)  as! VoicelynCell
                cellUnlighted.isHighlighted = false
                lastIndexPathSelected = cellIndexPath
            }
        }
        else if gesture.state == .ended {
            let stopPoint = gesture.location(in: collectionView)
            guard let cellIndexPath = collectionView.indexPathForItem(at: stopPoint) else {return}
            guard let lastCellIndexPath = lastIndexPathSelected else {return}
            let cellHighlighted =  collectionView.cellForItem(at: cellIndexPath) as! VoicelynCell
            cellHighlighted.isSelected = true
            let cellUnlighted = collectionView.cellForItem(at: lastCellIndexPath) as! VoicelynCell
            cellUnlighted.isHighlighted = false
            cellHighlighted.isSelected = false
        }
    }
    
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        collectionView.register(VoicelynCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    //MARK: - CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhoneNumbersAvailable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VoicelynCell
        cell.delegate = delegate
        cell.phoneNumber = allPhoneNumbersAvailable[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Pressed Row ", indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! VoicelynCell
        print("highlighted row: ", indexPath.item)
        print("seleccionada: ", cell.isSelected)
        print("highlighted: ", cell.isHighlighted)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! VoicelynCell
        print("unhighlighted row: ", indexPath.item)
        print("seleccionada: ", cell.isSelected)
        print("highlighted: ", cell.isHighlighted)
    }
}
