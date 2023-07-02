//
//  CreateEmployeeVC.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit
import ObjectMapper

class CreateEmployeeVC: BaseVC, UITableViewDataSource, UITableViewDelegate {

    var actionOK: ClosureAction?
    var employee: PEmployee = PEmployee()
    var actionUpdateOK: ClosureCustom<PEmployee>?
    var statusCreateOrUpdate = 1
    let dateFormater = DateFormatter()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "CreateEmployeeCell")
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    
    func bindDataEdit(item: PEmployee){
        employee =  item
        statusCreateOrUpdate = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEmployeeCell", for: indexPath) as? CreateEmployeeCell else {return UITableViewCell()}
        
        if statusCreateOrUpdate == 0 {
            cell.bindDataUpdate(item: employee)
        }
        
        cell.actionOK = {
            [weak self] item in
            guard let self = self else {return}
            self.employee = item
            if self.statusCreateOrUpdate == 1 {
                self.createEmployee()
            }else {
                self.updateEmployee()
            }
        }
        return cell
    }
    
    func createEmployee(){
        employee.sign()
        ServiceManager.common.createEmployee(param: employee){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionOK?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
        
    }
    func updateEmployee(){
        employee.sign()
        ServiceManager.common.updateEmployee(param: employee){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionUpdateOK?(self.employee)
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
}
