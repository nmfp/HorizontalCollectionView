//
//  ContainerView.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 24/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    
    var phoneNumber: CountryPhoneNumber? {
        didSet {
            guard let contact = phoneNumber else {return}
            
            countryImageView.image = UIImage(named: contact.imageName)
            numberLabel.text = contact.number
            
            let attributedText = NSMutableAttributedString(string: "\(minutesLeft)", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)])
            attributedText.append(NSAttributedString(string: " min left | $ ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)]))
            attributedText.append(NSMutableAttributedString(string: "\(pricePerMinute)", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)]))
            attributedText.append(NSAttributedString(string: "/min", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)]))
            
            rateLabel.attributedText = attributedText
        }
    }
    
    let imageHeight: CGFloat = 15
    
    var minutesLeft = 0
    var pricePerMinute = 0
    
    let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var countryImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = imageHeight / 2
        return iv
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "\(minutesLeft)", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)])
        attributedText.append(NSAttributedString(string: " min left | $ ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)]))
        attributedText.append(NSMutableAttributedString(string: "\(pricePerMinute)", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)]))
        attributedText.append(NSAttributedString(string: "/min", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 0, green: 185, blue: 199)]))
        
        label.attributedText = attributedText
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(fromLabel)
        addSubview(countryImageView)
        addSubview(numberLabel)
        addSubview(rateLabel)
        
        fromLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 50, height: 15)
        countryImageView.anchor(top: nil, left: fromLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: imageHeight, height: imageHeight)
        countryImageView.centerYAnchor.constraint(equalTo: fromLabel.centerYAnchor).isActive = true
        numberLabel.anchor(top: fromLabel.topAnchor, left: countryImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        rateLabel.anchor(top: nil, left: fromLabel.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 15)
    }
}

