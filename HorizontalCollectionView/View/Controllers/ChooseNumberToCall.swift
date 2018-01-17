//
//  ChooseNumberOrigin.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class ChooseNumberToCall: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var contact: VoicelynContact? {
        didSet {
            guard let contact = contact else {return}
            nameLabel.text = "    " + contact.name
            numberLabel.text = contact.phoneNumbers[0] + "    "
        }
    }
    
    let ownerContact = OwnerContact()
    
    let containerViews: UIView = {
        let cv = UIView()
        let iv = UIImageView(image: #imageLiteral(resourceName: "Perfil"))
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor(white: 1, alpha: 0.4)
        return cv
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "profile"))
        iv.backgroundColor = .orange
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        return label
    }()
    
    let blackView = UIView()
    
    lazy var customCollection: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = true
        return cv
    }()
    
    lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.nameLabel, self.numberLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(self.labelStackView)
        self.labelStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.backgroundColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 0.6)
        return view
    }()
    
    let headerId = "headerId"
    let cellId = "cellId"
    let testCellId = "testCellId"
    
    var contactsViewController: ContactsViewController?
    
    func showNumbersToCallView() {
        print("showNumbersToCall...")
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(containerView)
            window.addSubview(profileImageView)
            window.addSubview(containerView)
            window.addSubview(customCollection)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let height = window.frame.height / 2
            let y = window.frame.height - height
            
            self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            self.profileImageView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 120)
            self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 30)
            self.customCollection.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height - self.profileImageView.frame.height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.profileImageView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.profileImageView.frame.height)
                self.containerView.frame = CGRect(x: 0, y: y + self.profileImageView.frame.height - self.containerView.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.customCollection.frame = CGRect(x: 0, y: y + self.profileImageView.frame.height, width: self.customCollection.frame.width, height: self.customCollection.frame.height)
            }, completion: nil)
        }
    }
    
    func scrollToSection(_ section:Int)  {
            let indexPath = IndexPath(item: 1, section: section)
            if let attributes =  customCollection.layoutAttributesForSupplementaryElement(ofKind: UICollectionElementKindSectionHeader, at: indexPath) {
                let topOfHeader = CGPoint(x: 0, y: attributes.frame.origin.y - customCollection.contentInset.top)
                customCollection.setContentOffset(topOfHeader, animated:true)
            }
    }
    
    @objc func handleDismiss() {
        print("HandleDismiss...")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.profileImageView.frame = CGRect(x: 0, y: window.frame.height, width: self.profileImageView.frame.width, height: self.profileImageView.frame.height)
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.customCollection.frame = CGRect(x: 0, y: window.frame.height, width: self.customCollection.frame.width, height: self.customCollection.frame.height)
            }
        }, completion: {finished in
            //Obrigar a collectionView a fazer scroll para o topo para quando for novamente mostrada estar no inicio
            self.scrollToSection(0)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customCollection.register(HeaderNumberCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        customCollection.register(ChooseDifferentNumberCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("CEMAS contas")
        return ownerContact.allMyNumbers.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChooseDifferentNumberCell
        cell.phoneNumber = ownerContact.allMyNumbers.filter {$0.number != ownerContact.numberInUse.number}[indexPath.item]
        return cell
    }
    
    //MARK: - FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Nao pode ser colocado desta maneira pois este devolve largura a zero
        print("LARGURA CELULA: ", collectionView.frame.width)
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderNumberCell
        header.phoneNumberInUse = ownerContact.numberInUse
        return header
    }
}
