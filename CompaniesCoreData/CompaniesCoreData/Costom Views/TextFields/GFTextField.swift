//
//  GFTextField.swift
//  Git-demo
//
//  Created by Shyngys on 17.02.2020.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 0.5
        layer.borderColor           = UIColor.systemGray4.cgColor
//        frame.size.width            = 100
//        frame.size.height           = 50
        
        textColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 8
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .go
        placeholder                 = "Enter a username"
    }

}
