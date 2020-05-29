//
//  UILabel+ext.swift
//  CompaniesCoreData
//
//  Created by Shyngys Saktagan on 5/8/20.
//  Copyright © 2020 ShyngysSaktagan. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false

    }
}


extension UITextField {
    convenience init(placeHolder: String) {
        self.init(frame: .zero)
        self.placeholder = placeHolder
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autocorrectionType          = .no
    }
}   

//
//extension UIImageView {
//    convenience init(image: UIImage, selector: Selector) {
//        self.init(frame: .zero)
//        self.image                                      = image
//        self.contentMode                                = .scaleAspectFill
//        self.isUserInteractionEnabled                   = true
//        self.translatesAutoresizingMaskIntoConstraints  = false
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
//    }
//}


extension UIDatePicker {
    convenience init(mode: UIDatePicker.Mode) {
        self.init(frame: .zero)
        self.datePickerMode = mode
        self.translatesAutoresizingMaskIntoConstraints  = false
    }
}



