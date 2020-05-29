//
//  CreateCompanyController.swift
//  CompaniesCoreData
//
//  Created by Shyngys Saktagan on 5/7/20.
//  Copyright © 2020 ShyngysSaktagan. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,  CreateCompanyControllerDelegate {
    
    var company : Company? {
        didSet {
            nameTextField.text = company?.name
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
                setupCircularImageStyle()
            }
            
            if let founded = company?.founded {
                datePicker.date = founded
            }
        }
    }
    
    var delegate : CreateCompanyControllerDelegate?
    
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        
        return imageView
    }()
    let nameLabel               = UILabel(text: Labels.name, font: UIFont.boldSystemFont(ofSize: 16))
    let nameTextField           = UITextField(placeHolder: PlaceHolderLabels.enterName)
    let datePicker              = UIDatePicker(mode: .date)
    
    
    @objc func handleSelectPhoto() {
        let imagePickerController                       = UIImagePickerController()
        imagePickerController.delegate                  = self
        imagePickerController.allowsEditing             = true
        imagePickerController.modalPresentationStyle    = .fullScreen
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let editedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            companyImageView.image = editedImage
        } else if let originalImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            companyImageView.image = originalImage
        }
        
        setupCircularImageStyle()
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func didEditCompany(company: Company) {
        delegate?.didEditCompany(company: company)
    }
    
    
    func didAddCompany(company: Company) {
        delegate?.didAddCompany(company: company)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Creat Company" : "Change Company"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        configureNavigationBar(largeTitleColor: .label, backgoundColor: .systemBackground, tintColor: .systemRed, title: navigationBarTitles.creatCompany, preferredLargeTitle: true)
        configureNavigationBarItems()
        setupUI()
    }
    
    
    func configureNavigationBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        setupCancelButton()
    }
    
    
    func creatCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
            
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company.setValue(imageData, forKey: "imageData")
        }
            
        do  {
            try context.save()
            dismiss(animated: true) {
                self.didAddCompany(company: company as! Company)
            }
        } catch let saveErr {
            print(errorMessage.failedToSave, saveErr)
        }
    }
    
    
    func changeCompany(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        company?.name           = nameTextField.text
        company?.founded        = datePicker.date
        
        if let imageData = companyImageView.image {
            company?.imageData  = imageData.jpegData(compressionQuality: 0.8)
        }
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.didEditCompany(company: self.company!)
            }
        } catch let saveErr {
            print("Failed to save company:", saveErr)
        }
    }
    
    
    @objc func handleSave() {
        if company == nil {
            creatCompany()
        }else {
            changeCompany()
        }
    }
    
    
    private func setupCircularImageStyle() {
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds      = true
        companyImageView.layer.borderColor  = UIColor.darkBlue.cgColor
        companyImageView.layer.borderWidth  = 2
    }
    
    
    func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(companyImageView)
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            companyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            companyImageView.widthAnchor.constraint(equalToConstant: 100),
            companyImageView.heightAnchor.constraint(equalToConstant: 100),
            companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
