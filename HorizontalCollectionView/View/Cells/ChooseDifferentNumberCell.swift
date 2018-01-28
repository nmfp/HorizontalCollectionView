//
//  ChooseNumberCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

protocol DifferentNumberToCallProtocol {
    func handleChooseDifferentNumberToCall(cell: ChooseDifferentNumberCell)
    func handleOptionOfCallerNumber(view: UIView)
}

class ChooseDifferentNumberCell: BaseCell {
    
    var phoneNumber: CountryPhoneNumber? {
        didSet {
            guard let phoneNumber = phoneNumber else {return}
            countryLabel.text = phoneNumber.country
            phoneNumberLabel.text = phoneNumber.number
        }
    }
    
    var delegate: ChooseNumberToCall?
    
    let height: CGFloat = 20
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Test country"
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+351961234567"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.rgb(red: 158, green: 158, blue: 158)
        return label
    }()
    
    lazy var countryImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = height / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var phoneNumberStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.countryLabel, self.phoneNumberLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCallNumber)))
        return stack
    }()
    
    @objc func handleCallNumber() {
        delegate?.handleChooseDifferentNumberToCall(cell: self)
    }
    
    override func setupViews() {
        addSubview(countryImageView)
        addSubview(phoneNumberStackView)
        
        countryImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: height, height: height)
        
        phoneNumberStackView.anchor(top: topAnchor, left: countryImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
    }
}
