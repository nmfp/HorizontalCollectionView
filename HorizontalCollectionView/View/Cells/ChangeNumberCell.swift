//
//  ChangeNumberCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 22/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit


protocol KeypadDelegate {
    func handleChangeNumberTapped(for phoneNumber: String)
}

class ChangeNumberCell: BaseCell {
    
    var phoneNumber: String? {
        didSet {
            guard let phoneNumber = phoneNumber else {return}
            numberLabel.text = phoneNumber
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor.green : .white
            numberLabel.textColor = isHighlighted ? UIColor.white : .black
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.green : .white
            numberLabel.textColor = isSelected ? UIColor.white : .black
        }
    }
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .white
        
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        addSubview(numberLabel)
        numberLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
