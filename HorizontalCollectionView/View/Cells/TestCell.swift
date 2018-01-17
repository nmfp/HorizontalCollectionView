//
//  TestCell.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 17/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textColor = .white
        label.text = "CENAS"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(testLabel)
        testLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
