//
//  CompaniesController.swift
//  CompaniesCoreData
//
//  Created by Shyngys Saktagan on 5/7/20.
//  Copyright © 2020 ShyngysSaktagan. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    
    var companies = [Company]()
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
    func didEditCompany(company: Company) {
        let row             = companies.firstIndex(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.companies = CoreDataManager.shared.fetchCompanies()
        tableView.register(CompaniesControllerCell.self, forCellReuseIdentifier: "cell")
        setupPlusButtonInNavBar(selector: #selector(addButton))
        configure()
    }
    
    
    func configure() {
        configureNavigationBar(largeTitleColor: .label, backgoundColor: .systemBackground, tintColor: .systemRed, title: "Companies", preferredLargeTitle: true)
        view.backgroundColor        = .white
        tableView.backgroundColor   = .systemBackground
        tableView.separatorColor    = .white
        tableView.tableFooterView   = UIView()
        tableView.separatorStyle    = .none

    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") {  (action, view, completion) in
            let context = CoreDataManager.shared.persistentContainer.viewContext
            let company = self.companies[indexPath.row]
            
            self.companies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            context.delete(company)
            
            do {
                try context.save()
                completion(true)
            } catch let error {
                print("Error \(error)")
            }
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            let creatCompanyController                  = CreateCompanyController()
            let navigationController                    = UINavigationController(rootViewController: creatCompanyController)
            creatCompanyController.delegate             = self
            creatCompanyController.company              = self.companies[indexPath.row]
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        }
        
        edit.backgroundColor    = .systemGray3
        edit.image              = UIImage(systemName: "slider.horizontal.3")
        
        delete.backgroundColor  = .lightRed
        delete.image            = UIImage(systemName: "trash")
        
        let swipeActions        = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeActions
    }
    
    
    @objc func addButton() {
        let creatCompanyController  = CreateCompanyController()
        let navigationController    = UINavigationController(rootViewController: creatCompanyController)
        
        creatCompanyController.delegate             = self
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emplpyeesController = EmployeesController()
        emplpyeesController.company = self.companies[indexPath.row]
        navigationController?.pushViewController(emplpyeesController, animated: true)
        
    }
        
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompaniesControllerCell
        let company     = companies[indexPath.row]
        cell.company    = company
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
