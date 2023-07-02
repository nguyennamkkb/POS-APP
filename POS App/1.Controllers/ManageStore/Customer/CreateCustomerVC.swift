//
//  CreateCustomerVC.swift
//  POS App
//
//  Created by namnl on 21/05/2023.
//

import UIKit

class CreateCustomerVC: BaseVC, UITableViewDataSource, UITableViewDelegate{
    
    var actionOk: ClosureAction?
    var customer: PCustomer = PCustomer()
    var actionUpdateOK: ClosureCustom<PCustomer>?
    var statusCreateOrUpdate = 1
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "CreateCustomerCell")
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    func bindDataEdit(item: PCustomer){
        customer =  item
        statusCreateOrUpdate = 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCustomerCell", for: indexPath) as? CreateCustomerCell else {return UITableViewCell()}
        if statusCreateOrUpdate == 0 {
            cell.bindDataUpdate(item: customer)
        }
        
        cell.actionOK = {
            [weak self] item in
            guard let self = self else {return}
            self.customer = item
            if self.statusCreateOrUpdate == 1 {
                self.createCustomer()
            }else {
                self.updateCustomer()
            }
        }
        return cell
    }

    func createCustomer(){
        customer.sign()
        self.showLoading()
        ServiceManager.common.createCustomer(param: customer){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionOk?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
        
    }
    func updateCustomer(){
        customer.sign()
        ServiceManager.common.updateCustomer(param: customer){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionUpdateOK?(self.customer)
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
}
