//
//  CreateCustomerVC.swift
//  POS App
//
//  Created by namnl on 21/05/2023.
//

import UIKit
import MobileCoreServices
class CreateCustomerVC: BaseVC, UITableViewDataSource, UITableViewDelegate{
    
    let imagePicker = UIImagePickerController()
    var customer: PCustomer = PCustomer()
    let baseVC = BaseVC()
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCustomerCell", for: indexPath) as? CreateCustomerCell else {return UITableViewCell()}
        
        cell.actionOK = {
            [weak self] item in
            guard let self = self else {return}
            self.customer = item
            
            self.createCustomer()

        }
        return cell
    }

    func createCustomer(){
        self.showLoading()
        ServiceManager.common.createCustomer(param: customer){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
        
    }
}
