//
//  Contact.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 10/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit
import Contacts

struct VoicelynContact {
    var name: String
    var profileImage: UIImage?
    var phoneNumbers: [String]
    var isFavourited: Bool
    
    init(contact: CNContact) {
        self.name = contact.givenName + " " + contact.familyName
        if let data = contact.imageData {
            self.profileImage = UIImage(data: data)
        }
        else {
            self.profileImage = #imageLiteral(resourceName: "Perfil")
        }
        self.isFavourited = false
        self.phoneNumbers = [String]()
        for phoneNumber in contact.phoneNumbers {
            self.phoneNumbers.append(phoneNumber.value.stringValue)
        }
    }
}
