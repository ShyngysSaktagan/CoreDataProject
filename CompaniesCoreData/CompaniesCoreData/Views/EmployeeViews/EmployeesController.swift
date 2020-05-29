//
//  EmployeesController.swift
//  CompaniesCoreData
//
//  Created by Shyngys Saktagan on 5/8/20.
//  Copyright © 2020 ShyngysSaktagan. All rights reserved.
//

import UIKit

class IndentedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: insets)
        super.drawText(in: customRect)
    }
    
}

class EmployeesController : UITableViewController, CreateEmployeeControllerDelegate {
    
    var company : Company?
    var allEmployees    = [[Employee]]()
    let employeeTypes   = [
        EmployeeType.Intern.rawValue,
        EmployeeType.Executive.rawValue,
        EmployeeType.SeniorManagement.rawValue,
        EmployeeType.Staff.rawValue,
    ]
    
    
    func didAddEmployee(employee: Employee) {
        
        guard let section       = employeeTypes.firstIndex(of: employee.type!) else { return }
        let row                 = allEmployees[section].count
        let insertionIndexPath  = IndexPath(row: row, section: section)
        
        allEmployees[section].append(employee)
        
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmployees()
        tableView.backgroundColor = .systemBackground
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    
    @objc func handleAdd() {
        let createEmployeeController            = CreateEmployeeController()
        createEmployeeController.delegate       = self
        createEmployeeController.company        = company
        let navController                       = UINavigationController(rootViewController: createEmployeeController)
        navController.modalPresentationStyle    = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employee?.allObjects as? [Employee] else {return}
        allEmployees = []
        
        employeeTypes.forEach { (employeeType) in
            allEmployees.append(
                companyEmployees.filter{$0.type == employeeType}
            )
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label               = IndentedLabel()
        label.text              = employeeTypes[section]
        label.backgroundColor   = .systemGray3
        label.textColor         = .label
        label.font              = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return employeeTypes.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let employee            = allEmployees[indexPath.section][indexPath.row]
        cell.textLabel?.text    = employee.name
        
        if let birthday = employee.employeeInformation?.birthday {
            let dateFormatter           = DateFormatter()
            dateFormatter.dateFormat    = "MMM dd, yyyy"
            cell.textLabel?.text        = "\(employee.name ?? "")    \(dateFormatter.string(from: birthday))"
        }
                
        cell.backgroundColor        = .systemGray5
        cell.textLabel?.textColor   = .label
        cell.textLabel?.font        = UIFont.boldSystemFont(ofSize: 15)
        
        return cell
    }
}
