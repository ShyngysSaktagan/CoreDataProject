//
//  CreateEmployeeController.swift
//  CompaniesCoreData
//
//  Created by Shyngys Saktagan on 5/8/20.
//  Copyright © 2020 ShyngysSaktagan. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var company : Company?
    var delegate: CreateEmployeeControllerDelegate?

    let nameLabel           = UILabel(text: Labels.name, font: UIFont.boldSystemFont(ofSize: 16))
    let birthdayLabel       = UILabel(text: Labels.birthday, font: UIFont.boldSystemFont(ofSize: 16))
    let nameTextField       = UITextField(placeHolder: PlaceHolderLabels.enterName)
    let birthdayTextField   = UITextField(placeHolder: PlaceHolderLabels.birthday)
    
    let employeeTypeSegmentedControl: UISegmentedControl = {
        let types = [
            EmployeeType.Intern.rawValue,
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagement.rawValue,
            EmployeeType.Staff.rawValue,
        ]
        
        let sc                  = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.tintColor            = UIColor.darkBlue
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        view.backgroundColor                = .systemGray5
        setupCancelButton()
        setupUI()
        configureNavigationBar(largeTitleColor: .label, backgoundColor: .systemBackground, tintColor: .systemRed, title: navigationBarTitles.creatEmployee, preferredLargeTitle: true)
     }
     
     
    @objc func handleSave() {
        guard let employeeName  = nameTextField.text else { return }
        guard let company       = self.company else { return }
        guard let birthdayText  = birthdayTextField.text else { return }
        
        if birthdayText.isEmpty {
            showError(title: errorTitle.emptyBirthday, message: errorMessage.emptyBirthday)
            return
        }
        
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MM/dd/yyyy"
        
        guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
            showError(title: errorTitle.badDate, message: errorMessage.badDate)
            return
        }
        
        guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }
        let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName, employeeType: employeeType, birthday: birthdayDate,company: company)
        
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true, completion: {
                self.delegate?.didAddEmployee(employee: tuple.0!)
            })
        }
    }
        
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayTextField)
        view.addSubview(employeeTypeSegmentedControl)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
            nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            
            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            birthdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            birthdayLabel.widthAnchor.constraint(equalToConstant: 100),
            birthdayLabel.heightAnchor.constraint(equalToConstant: 50),
            
            birthdayTextField.leftAnchor.constraint(equalTo: birthdayLabel.rightAnchor),
            birthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor),
            birthdayTextField.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor),
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.topAnchor),
            
            
            employeeTypeSegmentedControl.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 0),
            employeeTypeSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            employeeTypeSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            employeeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 34),
        ])


    }
}
