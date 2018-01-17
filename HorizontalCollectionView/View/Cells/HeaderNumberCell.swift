//
//  OriginNumberCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class HeaderNumberCell: UICollectionViewCell {
    
    var phoneNumberInUse: CountryPhoneNumber? {
        didSet {
            guard let phoneNumber = phoneNumberInUse else {return}
            countryLabel.text = phoneNumber.country
            let attributedText = NSMutableAttributedString(string: phoneNumber.number, attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 158, green: 158, blue: 158), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
            phoneNumberLabel.attributedText = attributedText
//            phoneNumberLabel.text = phoneNumber.number
        }
    }
    
    var delegate: DifferentNumberToCallProtocol?
    
    let height: CGFloat = 20
    
    let topTypeLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "   CALL FROM", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        label.attributedText = attributedText
//        label.text = "   CALL FROM"
//        label.backgroundColor = .blue
        return label
    }()
    
    let bottomTypeLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "   USE A DIFFERENT NUMBER", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        label.attributedText = attributedText
//        label.backgroundColor = .orange
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
    
    lazy var justOnceButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "JUST ONCE", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 1, green: 184, blue: 198), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)])
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleJustOnce), for: .touchUpInside)
        return button
    }()
    
    lazy var alwaysButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "ALWAYS", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 1, green: 184, blue: 198), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)])
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleAlways), for: .touchUpInside)
        return button
    }()
    
    lazy var phoneNumberStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.countryLabel, self.phoneNumberLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
//        stack.backgroundColor = .orange
        return stack
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.justOnceButton, self.alwaysButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
//        stack.backgroundColor = .orange
        return stack
    }()
    
    @objc func handleJustOnce() {
        print("Call Just Once")
        delegate?.handleOptionOfCallerNumber(view: justOnceButton)
    }
    
    @objc func handleAlways() {
        print("Call Always")
        delegate?.handleOptionOfCallerNumber(view: alwaysButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
//        setupStackView()
        
//        let buttonStackView = UIStackView(arrangedSubviews: [countryLabel, phoneNumberLabel])
//        buttonStackView.axis = .horizontal
//        buttonStackView.distribution = .fillProportionally
        
//        addSubview(buttonStackView)
//        buttonStackView.anchor(top: phoneNumberStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: self.frame.width / 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
//        backgroundColor = .red
        
        addSubview(topTypeLabel)
        addSubview(countryImageView)
        addSubview(phoneNumberStackView)
        addSubview(buttonStackView)
        addSubview(bottomTypeLabel)
        
        topTypeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        countryImageView.anchor(top: topTypeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: height, height: height)
        
        phoneNumberStackView.anchor(top: topTypeLabel.bottomAnchor, left: countryImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
        buttonStackView.anchor(top: phoneNumberStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: self.frame.width / 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        bottomTypeLabel.anchor(top: buttonStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        print("LARGURA ELEMENTOS: ", topTypeLabel.frame.height + phoneNumberStackView.frame.height + bottomTypeLabel.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
