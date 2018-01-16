//
//  OriginNumberCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class OriginNumberCell: ChooseDifferentNumberCell {
    
    var phoneNumberInUse: CountryPhoneNumber? {
        didSet {
            guard let phoneNumber = phoneNumber else {return}
            countryLabel.text = phoneNumber.country
            phoneNumberLabel.text = phoneNumber.number
        }
    }
    
    lazy var justOnceButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "JUST ONCE", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 1, green: 184, blue: 198)])
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleJustOnce), for: .touchUpInside)
        return button
    }()
    
    lazy var alwaysButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "ALWAYS", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 1, green: 184, blue: 198)])
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleAlways), for: .touchUpInside)
        return button
    }()
    
    @objc func handleJustOnce() {
        print("Call Just Once")
    }
    
    @objc func handleAlways() {
        print("Call Always")
    }
    
    override func setupViews() {
        
//        setupStackView()
        
        let buttonStackView = UIStackView(arrangedSubviews: [countryLabel, phoneNumberLabel])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillProportionally
        addSubview(buttonStackView)
        
        buttonStackView.anchor(top: phoneNumberStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: self.frame.width / 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [countryLabel, phoneNumberLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        addSubview(stackView)
    }
}
