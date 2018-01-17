//
//  ChooseNumberCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

protocol DifferentNumberToCallProtocol {
    func handleChooseDifferentNumberToCall(cell: BaseCell)
    func handleOptionOfCallerNumber(view: UIView)
}

class ChooseDifferentNumberCell: BaseCell {
    
    var phoneNumber: CountryPhoneNumber? {
        didSet {
            guard let phoneNumber = phoneNumber else {return}
            countryLabel.text = phoneNumber.country
            let attributedText = NSMutableAttributedString(string: phoneNumber.number, attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 158, green: 158, blue: 158), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
            phoneNumberLabel.attributedText = attributedText
//            phoneNumberLabel.text = phoneNumber.number
        }
    }
    

    
    let height: CGFloat = 20
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "CALL FROM"
//        label.backgroundColor = .blue
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Test country"
//        label.backgroundColor = .purple
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+351961234567"
//        label.backgroundColor = .yellow
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
//        stack.backgroundColor = .orange
        return stack
    }()
    
    override func setupViews() {
//        addSubview(typeLabel)
        addSubview(countryImageView)
        addSubview(phoneNumberStackView)
        
//        typeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        countryImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: height, height: height)
//        countryImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        phoneNumberStackView.anchor(top: nil, left: countryImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 6, width: 0, height: 30)
//        phoneNumberStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countryImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: height, height: height)
        
        phoneNumberStackView.anchor(top: topAnchor, left: countryImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
    }
}
