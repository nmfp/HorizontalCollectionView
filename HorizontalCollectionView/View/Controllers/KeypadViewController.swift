//
//  KeypadViewController.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 18/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class KeypadViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, KeypadDelegate {

    
    
    lazy var chooseNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Numero", for: .normal)
        button.backgroundColor = .yellow
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleShowAllNumbers), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .green
        return cv
    }()
    
    var collectionViewTopAnchor: NSLayoutConstraint?
    var collectionViewHeightAnchor: NSLayoutConstraint?
    
    let cellId = "cellId"
    
    let items = ["1234", "5678", "9012"]
    let marginCell: CGFloat = 10
    var isOpen = false
    
    @objc func handleShowAllNumbers() {
        handleShowCollectionView()
    }
    
    fileprivate func handleShowCollectionView() {
        if isOpen {
            return
        }
        isOpen = true
        
        collectionViewHeightAnchor?.isActive = false
        collectionViewHeightAnchor?.constant = CGFloat((items.count * 50)) + (CGFloat(items.count) * marginCell)
        print("CONSTANTE:      ", collectionViewHeightAnchor?.constant)
        collectionViewHeightAnchor?.isActive =  true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//            self.collectionViewTopAnchor?.isActive = true
//            self.collectionViewHeightAnchor?.isActive = true
            self.view.layoutIfNeeded()
            
//            self.view.layoutSubviews()
            print("CENTER aNTES DAS CONTAS: ", self.collectionView.center.y)
//            self.collectionView.center.y += self.collectionView.frame.height / 2
            print("CENTER: ", self.collectionView.center.y)
            print("CENTER VIEW: ", self.view.center.y)
            print("Height: ", self.collectionView.frame.height)
        }, completion: nil)
    }
    
    fileprivate func handleDismissNumbers() {
        if !isOpen {
            return
        }
        
        isOpen = false
        
        collectionViewHeightAnchor?.isActive = false
        collectionViewHeightAnchor?.constant = 0
        collectionViewHeightAnchor?.isActive =  true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//            self.collectionViewTopAnchor?.isActive = true
//            self.collectionViewHeightAnchor?.isActive = true
            
//            self.collectionViewTopAnchor?.isActive = false
//            self.collectionViewHeightAnchor?.isActive = false
//                        self.view.layoutIfNeeded()
            print("CENTER aNTES DAS CONTAS: ", self.collectionView.center.y)
//            self.collectionView.center.y -= ((self.collectionView.frame.height / 2) + 10)
            print("CENTER: ", self.collectionView.center.y)
            print("CENTER VIEW: ", self.view.center.y)
            print("Height: ", self.collectionView.frame.height)
//            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
            print("CENTER: ", self.collectionView.center.y)
            print("CENTER VIEW: ", self.view.center.y)
            print("Height: ", self.collectionView.frame.height)
        }, completion: nil)
    }
    
    //collectionViewHeightAnchor = collectionView.heightAnchor.constraint(equalToConstant: CGFloat((items.count * 50)) + (CGFloat(items.count) * marginCell))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(chooseNumberButton)
        chooseNumberButton.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
        chooseNumberButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: chooseNumberButton.bottomAnchor, left: chooseNumberButton.leftAnchor, bottom: nil, right: chooseNumberButton.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        collectionViewTopAnchor = collectionView.topAnchor.constraint(equalTo: chooseNumberButton.bottomAnchor, constant: 10)
        collectionViewHeightAnchor = collectionView.heightAnchor.constraint(equalToConstant: 0)
        
        collectionView.register(ChangeNumberCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.center = CGPoint(x: self.view.center.x, y: view.center.y + 25)
    }
    
    //MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChangeNumberCell
        print("CELULA")
        cell.delegate = self
        cell.phoneNumber = items[indexPath.item]
        return cell
    }
    
    //MARK: - FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 60, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return marginCell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return marginCell
//    }
    
    //MARK: - KeypadDelegate
    func handleChangeNumberTapped(for cell: ChangeNumberCell) {
        print("Numero escolhido: ", cell.phoneNumber ?? "")
        self.chooseNumberButton.setTitle(cell.phoneNumber, for: .normal)
        handleDismissNumbers()
    }
}

class MyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOQUE")
    }
}

protocol KeypadDelegate {
    func handleChangeNumberTapped(for cell: ChangeNumberCell)
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
    
    var delegate: KeypadDelegate?
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "TESTE"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTappingButton)))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc func handleTappingButton() {
        delegate?.handleChangeNumberTapped(for: self)
    }
    
    override func setupViews() {
        backgroundColor = .white
        
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        addSubview(numberLabel)
        numberLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
