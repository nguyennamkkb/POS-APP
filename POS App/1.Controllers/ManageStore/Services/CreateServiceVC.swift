//
//  CreateServiceVC.swift
//  POS App
//
//  Created by namnl on 15/06/2023.
//

import UIKit

class CreateServiceVC: BaseVC,  UITableViewDataSource, UITableViewDelegate  {

    var actionOK: ClosureAction?
    var services: PServices = PServices()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "CreateServiceCell")
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateServiceCell", for: indexPath) as? CreateServiceCell else {return UITableViewCell()}
        cell.dataCreate = {
            [weak self] item in
            guard let self = self else {return}
            self.services = item
            self.createServices()
        }
        return cell
    }
    
    func createServices(){
        print("services \(services.toJSON())")
        ServiceManager.common.createService(param: services){
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


    
}
