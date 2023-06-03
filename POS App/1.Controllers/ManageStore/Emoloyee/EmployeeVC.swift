//
//  EmployeeVC.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit
import ObjectMapper

class EmployeeVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var keySearch: UITextField!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewSearch: UIView!
    var tableData = [PEmployee]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "EmployeeItemCell")
        // Do any additional setup after loading the view.
//        getAllEployees()
    }
    
    func setupUI(){
        viewSearch.layer.borderWidth = 0.5
        viewSearch.layer.cornerRadius = myCornerRadius.corner10
        btnAdd.layer.cornerRadius = myCornerRadius.corner10
        btnSearch.layer.cornerRadius = myCornerRadius.corner10
    }
    override func viewDidAppear(_ animated: Bool) {
        getAllEployees()
    }
    @IBAction func btnGoHomepressed(_ sender: UIButton) {
        self.wrapRoot(vc: TabBarVC())
    }
    
    @IBAction func back(_ sender: Any) {
        self.onBackNav()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeItemCell", for: indexPath) as? EmployeeItemCell else {return UITableViewCell()}
        cell.binđata(name: tableData.itemAtIndex(index: indexPath.row)?.fullName ?? "")
        return cell
    }
    
    @IBAction func addNewEmployeePressed(_ sender: UIButton) {
        self.pushVC(controller: CreateEmployeeVC())
    }
    
    func getAllEployees(){
        guard let keySearch = keySearch.text else {return}
        
        let param = "?keySearch=\(keySearch)"
        ServiceManager.common.getAllEmployees(param: param){
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
