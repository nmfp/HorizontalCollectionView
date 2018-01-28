//
//  CustomButton.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 25/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class CustomButton: UIButton, ChangeDialerDelegate {
    
    var heightConstraint: NSLayoutConstraint?
    var isCollapsed = true
    
    var contact: OwnerContact? {
        didSet {
            guard let contact = contact else {return}
            contactTotalNumbers = contact.allMyNumbers.count > 1 ? contact.allMyNumbers.count - 1 : 0
            containerView.numberLabel.text = contact.numberInUse.number
            containerView.countryImageView.image = UIImage(named: contact.numberInUse.imageName)
        }
    }
    
    var contactTotalNumbers: Int?
    
    lazy var dropView: DropView = {
        let view = DropView()
        view.contactPerson = contact
        view.delegate = self
        return view
    }()
    
    let containerView = ContainerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func didMoveToSuperview() {
        super.superview?.addSubview(dropView)
        super.superview?.bringSubview(toFront: dropView)
        
        dropView.anchor(top: bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        heightConstraint = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Carreguei no botao novo...")
        
        if isCollapsed {
            handleExpandDropView()
        }
        else {
            handleCollapseDropView()
        }
    }
    
    func handleCollapseDropView(){
        isCollapsed = true
        print("collapsing...")
        heightConstraint?.isActive = false
        heightConstraint?.constant = 0
        heightConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    func handleExpandDropView(){
        guard let contactTotalNumbers = contactTotalNumbers, contactTotalNumbers > 0 else {return}
        
        isCollapsed = false
        
        heightConstraint?.isActive = false
        heightConstraint?.constant = CGFloat(contactTotalNumbers) * 54
        heightConstraint?.isActive = true
        print("Expanding \(contactTotalNumbers) rows...")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.dropView.layoutIfNeeded()
            self.dropView.center.y += self.dropView.frame.height / 2
        }, completion: nil)
    }
    
    func handleChangeDialerNumber(cell: VoicelynCell) {
        containerView.numberLabel.text = cell.containerView.numberLabel.text
        containerView.countryImageView.image = cell.containerView.countryImageView.image
        handleCollapseDropView()
    }
}
