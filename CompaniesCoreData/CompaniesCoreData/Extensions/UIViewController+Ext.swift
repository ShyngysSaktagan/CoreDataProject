//
//  UIViewController+Ext.swift
//  CompaniesCoreData
//
//  Created by Shyngys Saktagan on 5/7/20.
//  Copyright © 2020 ShyngysSaktagan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes                   = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes                        = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor                            = backgoundColor

            navigationController?.navigationBar.standardAppearance      = navBarAppearance
            navigationController?.navigationBar.compactAppearance       = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance    = navBarAppearance

            navigationController?.navigationBar.prefersLargeTitles      = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent           = false
            navigationController?.navigationBar.tintColor               = tintColor
            navigationItem.title                                        = title

        } else {
            navigationController?.navigationBar.barTintColor            = backgoundColor
            navigationController?.navigationBar.tintColor               = tintColor
            navigationController?.navigationBar.isTranslucent           = false
            navigationItem.title                                        = title
        }
    }
    
    
    func setupPlusButtonInNavBar(selector: Selector) {
        let addSymbol = UIImage(systemName: SFSymbols.addButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addSymbol, style: .plain, target: self, action: selector)
    }
    
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        let lightBlueBackgroundView             = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive  = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive                    = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive                  = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive                   = true
        
        return lightBlueBackgroundView
    }
}
