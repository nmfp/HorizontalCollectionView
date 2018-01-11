//
//  FavoriteCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 10/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var contact: VoicelynContact? {
        didSet {
            guard let contact = contact else {return}
            nameLabel.text = contact.name
            
            if let profileImage = contact.profileImage {
                self.profileImageView.image = profileImage
            }
        }
    }
    
    let height: CGFloat = 70
    var delegate: FavouriteContactProtocol?
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Perfil"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = height / 2
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTappingFavourite)))
        iv.backgroundColor = .red
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "teste"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .blue
        return label
    }()
    
    @objc func handleTappingFavourite() {
        print("Tap na favorite cell...")
//        delegate?.handleTappingFavourite(cell: self)
    }
    
    
     func setupViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        backgroundColor = .gray
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: height / 2, height: height / 2)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 15, paddingRight: 5, width: 0, height: 0)
    }
}
