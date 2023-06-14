//
//  CustomerVC.swift
//  POS App
//
//  Created by namnl on 04/06/2023.
//

import UIKit
import ObjectMapper

class CustomerVC: BaseVC, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var keySearch: UITextField!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var tableView: UITableView!
    
    var tableData = [PCustomer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "CustomerItemCell")
        // Do any additional setup after loading the view.
        setupUI()
        getAllCustomers()
    }
    func setupUI(){
        viewSearch.layer.borderWidth = 0.5
        viewSearch.layer.cornerRadius = myCornerRadius.corner10
        btnAdd.layer.cornerRadius = myCornerRadius.corner10
        btnSearch.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    
    @IBAction func goHomePressed(_ sender: UIButton) {
        self.wrapRoot(vc: TabBarVC())
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerItemCell", for: indexPath) as? CustomerItemCell else {return UITableViewCell()}
        
        let item = tableData[indexPath.row]
        
        cell.binđata(name: tableData.itemAtIndex(index: indexPath.row)?.fullName ?? "")
        
        cell.actionViewInfo = {
            [weak self] in
            guard let self = self else {return}
            let vc = CustomerDetailVC()
            vc.bindData(item: item)
            vc.deleteSuccess = {
                [weak self] in
                guard let self = self else {return}
                self.getAllCustomers()
            }
            self.present(vc, animated: true)
        }
        return cell
    }
    func getAllCustomers(){
        guard let keySearch = keySearch.text else {return}
        guard let id = Common.userMaster.id else {return}
        let param: String = "store_id=\(id)&status=1&keySearch=\(keySearch)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        ServiceManager.common.getAllCustomers(param: "?\(param)"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PCustomer>().mapArray(JSONObject: response!.data ) ?? [PCustomer]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    @IBAction func btnAddPressed(_ sender: UIButton) {
        let vc = CreateCustomerVC()
        vc.actionOk = {
            [weak self] in
            guard let self = self else {return}
            self.getAllCustomers()
        }
        self.pushVC(controller: vc)
    }
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        getAllCustomers()
    }
    

}
