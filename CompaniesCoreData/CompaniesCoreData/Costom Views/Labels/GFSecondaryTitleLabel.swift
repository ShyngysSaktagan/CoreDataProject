//
//  GFSecondaryTitleLabel.swift
//  Git-demo
//
//  Created by Shyngys on 08.03.2020.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat){
        super.init(frame: .zero)
        text = text
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
       
    private func configure(){
        textColor                                   = .secondaryLabel
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.9
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
