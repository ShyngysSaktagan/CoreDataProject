//
//  CompaniesControllerCell.swift
//  CompaniesCoreData
//
//  Created by Shyngys Saktagan on 5/7/20.
//  Copyright © 2020 ShyngysSaktagan. All rights reserved.
//

import UIKit

class CompaniesControllerCell: UITableViewCell {
    
    let companyImageView = UIImageView(image: UIImage(named: "select_photo_empty"))
    let nameFoundedDateLabel = UILabel()
    
    var company : Company? {
        didSet {
            nameFoundedDateLabel.text = company?.name
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
            if let name = company?.name, let founded = company?.founded {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                let dateString = "\(name) - Founded: \(foundedDateString)"
                nameFoundedDateLabel.text = dateString
            } else {
                nameFoundedDateLabel.text = company?.name
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        configureUI()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configureUI() {
        companyImageView.contentMode        = .scaleAspectFill
        companyImageView.clipsToBounds      = true
        companyImageView.layer.cornerRadius = 20
        companyImageView.layer.borderColor  = UIColor.darkBlue.cgColor
        companyImageView.layer.borderWidth  = 1
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameFoundedDateLabel.text           = "COMPANY NAME"
        nameFoundedDateLabel.font           = UIFont.boldSystemFont(ofSize: 16)
        nameFoundedDateLabel.textColor      = .label
        nameFoundedDateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupUI() {
        addSubview(companyImageView)
        addSubview(nameFoundedDateLabel)
        
        NSLayoutConstraint.activate([
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyImageView.heightAnchor.constraint(equalToConstant: 40),
            companyImageView.widthAnchor.constraint(equalToConstant: 40),
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameFoundedDateLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 16),
            nameFoundedDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameFoundedDateLabel.topAnchor.constraint(equalTo: topAnchor),
            nameFoundedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
