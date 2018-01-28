//
//  KeypadViewController.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 18/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class KeypadViewController: UIViewController {
    
    let ownerContact = OwnerContact()
    
    let myButton: MyButton = {
        let myButton = MyButton(frame: .zero)
        return myButton
    }()
    
    lazy var containerView: ContainerView = {
        let view = ContainerView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeNumberByView)))
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var numberButton: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.addTarget(self, action: #selector(handleChangeNumberByButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleChangeNumberByButton() {
        print("change number by button...")
    }
    
    @objc func handleChangeNumberByView() {
        print("change number by view...")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(myButton)
        myButton.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 50)
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        containerView.phoneNumber = ownerContact.numberInUse
        
        
        view.addSubview(numberButton)
        numberButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 160, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 54)
        
        numberButton.addSubview(containerView)
        containerView.anchor(top: numberButton.topAnchor, left: numberButton.leftAnchor, bottom: numberButton.bottomAnchor, right: numberButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        view.addSubview(customButton)
        customButton.anchor(top: myButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 54)
    }
    
    
    lazy var customButton: CustomButton = {
        let btn = CustomButton()
        btn.contact = ownerContact
        return btn
    }()
}




























































