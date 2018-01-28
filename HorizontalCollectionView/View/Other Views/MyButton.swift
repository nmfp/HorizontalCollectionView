//
//  MyButton.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 22/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class MyButton: UIButton, KeypadDelegate {
    
    lazy var dropDownView: DropDownView = {
        let view = DropDownView(frame: .zero)
        view.keypadDelegate = self
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var heightDropDownAnchor: NSLayoutConstraint?
    var isCollapsed = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    //Necessario adicionar a view e definir as contrains neste metodo pois so assim e possivel interagir com a collectionView
    override func didMoveToSuperview() {
        guard let superView = self.superview else {return}
        superView.addSubview(dropDownView)
        superView.bringSubview(toFront: dropDownView)
        dropDownView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dropDownView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dropDownView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        heightDropDownAnchor = dropDownView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    fileprivate func setupButton() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.backgroundColor = .yellow
        self.tintColor = UIColor.black
        self.setTitleColor(.black, for: .normal)
        self.setTitle("TESTE", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isCollapsed {
            handleShowNumbers()
        }
        else {
            handleDismissNumbers()
        }
    }
    
    fileprivate func handleShowNumbers() {
        isCollapsed = false
        
        heightDropDownAnchor?.isActive = false
        
        print("TAMANHO COLLECTION: ", self.dropDownView.numbersCollectionView.contentSize.height)
        if self.dropDownView.numbersCollectionView.contentSize.height > 160 {
            heightDropDownAnchor?.constant = 165
            self.dropDownView.numbersCollectionView.isScrollEnabled = true
        }
        else {
            heightDropDownAnchor?.constant = self.dropDownView.numbersCollectionView.contentSize.height + 5
            self.dropDownView.numbersCollectionView.isScrollEnabled = false
        }
        heightDropDownAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropDownView.layoutIfNeeded()
            self.dropDownView.center.y += self.dropDownView.frame.height / 2
        }, completion: nil)
    }
    
    fileprivate func handleDismissNumbers() {
        isCollapsed = true
        
        heightDropDownAnchor?.isActive = false
        heightDropDownAnchor?.constant = 0
        heightDropDownAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropDownView.center.y =  self.dropDownView.center.y - (self.dropDownView.frame.height / 2)
            self.dropDownView.layoutIfNeeded()
        }, completion: nil)
    }
    
    func handleChangeNumberTapped(for phoneNumber: String) {
        print("Numero seleccionado: ", phoneNumber)
        self.setTitle(phoneNumber, for: .normal)
        handleDismissNumbers()
    }
}

