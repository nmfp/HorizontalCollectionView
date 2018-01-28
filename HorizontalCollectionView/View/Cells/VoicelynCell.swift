//
//  VoicelynCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 25/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit


class VoicelynCell: UICollectionViewCell {
    
    var phoneNumber: CountryPhoneNumber? {
        didSet {
            containerView.phoneNumber = phoneNumber
        }
    }
    
    lazy var containerView: ContainerView = {
        let view = ContainerView()
        return view
    }()
    
    var delegate: ChangeDialerDelegate?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.fromLabel.textColor = .white
                containerView.numberLabel.textColor = .white
                containerView.rateLabel.textColor = .black
                self.backgroundColor = UIColor.rgb(red: 0, green: 185, blue: 199)
                delegate?.handleChangeDialerNumber(cell: self)
            }
            else {
                containerView.fromLabel.textColor = .black
                containerView.numberLabel.textColor = .black
                containerView.rateLabel.textColor = UIColor.rgb(red: 0, green: 185, blue: 199)
                self.backgroundColor = .white
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                containerView.fromLabel.textColor = .white
                containerView.numberLabel.textColor = .white
                containerView.rateLabel.textColor = .black
                self.backgroundColor = UIColor.rgb(red: 0, green: 185, blue: 199)
            }
            else {
                containerView.fromLabel.textColor = .black
                containerView.numberLabel.textColor = .black
                containerView.rateLabel.textColor = UIColor.rgb(red: 0, green: 185, blue: 199)
                self.backgroundColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
}
