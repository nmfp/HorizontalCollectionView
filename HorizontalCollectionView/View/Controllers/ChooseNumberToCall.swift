//
//  ChooseNumberOrigin.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class ChooseNumberToCall: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
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
    
    let contactLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Teste"
        label.backgroundColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 0.4)
        return label
    }()
    
    let blackView = UIView()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .yellow
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let headerId = "headerId"
    let cellId = "cellId"
    
    var contactsViewController: ContactsViewController?
    
    func showNumbersToCallView() {
         print("showNumbersToCall...")
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(containerView)
            window.addSubview(profileImageView)
            window.addSubview(contactLabel)
            window.addSubview(collectionView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let height = window.frame.height / 2
            print("HEIGHT: ", height)
            let y = window.frame.height - height
            self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            self.profileImageView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 120)
            self.contactLabel.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 30)
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height - self.profileImageView.frame.height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.profileImageView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.profileImageView.frame.height)
                self.contactLabel.frame = CGRect(x: 0, y: y + self.profileImageView.frame.height - self.contactLabel.frame.height, width: self.contactLabel.frame.width, height: self.contactLabel.frame.height)
                self.collectionView.frame = CGRect(x: 0, y: y + self.profileImageView.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                self.collectionView.reloadData()
            }, completion: {finished in
                print("Antes do refresh....")
                
                print("Depois do refresh....")
            })
        }
    }
    
    @objc func handleDismiss() {
        print("HandleDismiss...")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.profileImageView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.contactLabel.frame = CGRect(x: 0, y: window.frame.height, width: self.contactLabel.frame.width, height: self.contactLabel.frame.height)
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (finished) in
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CONSTRUTOR")
//        addSubview(containerView)
//        containerView.addSubview(profileImageView)
//        containerView.addSubview(contactLabel)
////        containerView.addSubview(collectionView)
////
//        profileImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
//        contactLabel.anchor(top: nil, left: containerView.leftAnchor, bottom: profileImageView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
//        collectionView.anchor(top: profileImageView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        collectionView.register(OriginNumberCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(ChooseDifferentNumberCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var contact: VoicelynContact? {
        didSet {
            guard let contact = contact else {return}
            contactLabel.text = "  " + contact.name + "         " + contact.phoneNumbers[0]
            print("CONTACT")
        }
    }
    
    let ownerContact = OwnerContact()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("CEMAS contas")
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChooseDifferentNumberCell
        cell.phoneNumber = ownerContact.allMyNumbers.filter {$0.number != ownerContact.numberInUse.number}[indexPath.item]
        print("CEMAS")
        return cell
    }
    
    //MARK: - FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! OriginNumberCell
        header.phoneNumberInUse = ownerContact.numberInUse
        return header
    }
}
