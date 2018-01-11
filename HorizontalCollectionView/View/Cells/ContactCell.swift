//
//  ContactCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 10/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

protocol FavouriteContactProtocol {
    func handleTappingContact(cell: BaseCell)
    func handleTappingFavourite(cell: BaseCell)
}

class ContactCell: BaseCell {
    
    var contact: VoicelynContact? {
        didSet {
            guard let contact = contact else {return}
            nameLabel.text = contact.name
            starButton.tintColor = contact.isFavourited ? UIColor.yellow : .lightGray
        }
    }
    
    var delegate: FavouriteContactProtocol?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.text = "teste"
        return label
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        button.tintColor = .yellow
        button.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
        return button
    }()
    
    override func setupViews() {
        backgroundColor = .blue
        
        addSubview(nameLabel)
        addSubview(starButton)
        
        nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: starButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        starButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
    }
    
    @objc func handleMarkAsFavourite() {
        delegate?.handleTappingContact(cell: self)
    }
}
