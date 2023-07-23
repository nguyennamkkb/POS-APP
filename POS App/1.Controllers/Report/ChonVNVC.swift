//
//  ChonVNVC.swift
//  POS App
//
//  Created by namnl on 22/07/2023.
//

import UIKit
import ObjectMapper

class ChonVNVC: BaseVC, UITableViewDataSource, UITableViewDelegate {

    var dataNV: ClosureCustom<PEmployee>?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var keySearch: UITextField!
    var tableData = [PEmployee]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource =  self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "EmployeeItemCell")
        // Do any additional setup after loading the view.
        getAllEployees()
    }
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeItemCell", for: indexPath) as? EmployeeItemCell else {return UITableViewCell()}
        let item = tableData[indexPath.row]
        cell.binđata(name: item.fullName ?? "")
        cell.actionViewInfo = {
            [weak self] in
            guard let self = self else {return}
            self.dataNV?(item)
            self.onBackNav()
        }
        
        return cell
    }
    

    func getAllEployees(){
        guard let keySearch = keySearch.text else {return}
        guard let id = Common.userMaster.id else {return}
        
        let param = ParamSearch(store_id: id, status: 1, keySearch: keySearch)

        ServiceManager.common.getAllEmployees(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PEmployee>().mapArray(JSONObject: response!.data ) ?? [PEmployee]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }

}
