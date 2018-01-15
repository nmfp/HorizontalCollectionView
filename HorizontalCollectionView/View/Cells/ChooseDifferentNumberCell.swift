//
//  ChooseNumberCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class ChooseDifferentNumberCell: BaseCell {
    
    var phoneNumber: CountryPhoneNumber? {
        didSet {
            guard let phoneNumber = phoneNumber else {return}
            countryLabel.text = phoneNumber.country
            phoneNumberLabel.text = phoneNumber.number
        }
    }
    
    let height: CGFloat = 20
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "CALL FROM"
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Test country"
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+351961234567"
        return label
    }()
    
    lazy var countryImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = height / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var phoneNumberStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.countryLabel, self.phoneNumberLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override func setupViews() {
        
//        setupStackView()
//        let stack = UIStackView(arrangedSubviews: [countryLabel, phoneNumberLabel])
//        stack.axis = .horizontal
//        stack.distribution = .equalSpacing
        addSubview(typeLabel)
        addSubview(countryImageView)
        addSubview(phoneNumberStackView)
        
        typeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        countryImageView.anchor(top: typeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 6, paddingBottom: 20, paddingRight: 0, width: height, height: height)
        phoneNumberStackView.anchor(top: typeLabel.bottomAnchor, left: countryImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 6, width: 0, height: 60)
    }
    
    fileprivate func setupStackView() {
        let stack = UIStackView(arrangedSubviews: [countryLabel, phoneNumberLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
    }
}
