//
//  ContactCellWithPhoto.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 11/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class ContactCellWithPhoto: BaseCell {
    
    var contact: VoicelynContact? {
        didSet {
            guard let contact = contact else {return}
            nameLabel.text = contact.name
            starButton.tintColor = contact.isFavourited ? UIColor.rgb(red: 255, green: 206, blue: 27) : UIColor.rgb(red: 225, green: 225, blue: 225)
            
            if let profileImage = contact.profileImage {
                self.profileImageView.image = profileImage
            }
        }
    }
    
    let height: CGFloat = 50
    var delegate: FavouriteContactProtocol?
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Perfil"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = height / 2
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "teste"
        return label
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        button.tintColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        button.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
        return button
    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(starButton)
        addSubview(separatorLineView)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 0, width: height, height: height)
        nameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: starButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        starButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
        starButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        separatorLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    @objc func handleMarkAsFavourite() {
        delegate?.handleTappingContact(cell: self)
    }
}
