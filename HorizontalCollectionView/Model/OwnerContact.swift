//
//  OwnerContact.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 15/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

struct OwnerContact {
    var numberInUse: CountryPhoneNumber
    var allMyNumbers: [CountryPhoneNumber]
    
    init() {
        self.numberInUse = CountryPhoneNumber(dictionary: ["country" : "Portugal","image": "PT", "number": "+351967968483"])
        self.allMyNumbers = [
            CountryPhoneNumber(dictionary: ["country" : "Portugal","image": "PT", "number": "+351967968483"]),
            CountryPhoneNumber(dictionary: ["country" : "Portugal","image": "PT", "number": "+351914627759"]),
            CountryPhoneNumber(dictionary: ["country" : "United Kingdom","image": "UK", "number": "+4423471378291"]),
            CountryPhoneNumber(dictionary: ["country" : "United States","image": "US", "number": "+164353538483"])]
    }
}

struct CountryPhoneNumber {
    var country: String
    var number: String
    var imageName: String
    
    init(dictionary: [String: String]) {
        self.country = dictionary["country"] ?? ""
        self.number = dictionary["number"] ?? ""
        self.imageName = dictionary["image"] ?? ""
    }
}
