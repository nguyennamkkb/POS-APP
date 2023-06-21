//
//  ServiceVC.swift
//  POS App
//
//  Created by namnl on 14/06/2023.
//

import UIKit
import ObjectMapper

class ServiceVC:BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var keySearch: UITextField!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewSearch: UIView!
    var tableData = [PServices]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "ServiceItemCell")
        // Do any additional setup after loading the view.
        getAllServices()
    }
    
    func setupUI(){
        viewSearch.layer.borderWidth = 0.5
        viewSearch.layer.cornerRadius = myCornerRadius.corner10
        btnAdd.layer.cornerRadius = myCornerRadius.corner10
        btnSearch.layer.cornerRadius = myCornerRadius.corner10
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceItemCell", for: indexPath) as? ServiceItemCell else {return UITableViewCell()}
        let item = tableData[indexPath.row]
        cell.bindData(item: item)
        
        cell.actionViewInfo = {
            [weak self] in
            guard let self = self else {return}
            let vc = ServiceDetailVC()
            vc.bindData(item: item)
            vc.deleteSuccess = {
                [weak self] in
                guard let self = self else {return}
                self.getAllServices()
            }
            self.present(vc, animated: true)
        }
        return cell
    }
    
    @IBAction func addNewServicesPressed(_ sender: UIButton) {
        let vc  = CreateServiceVC()
        vc.actionOK = {
            [weak self] in
            guard let self = self else {return}
            self.getAllServices()
        }
        self.pushVC(controller: vc)
        
    }
    
    func getAllServices(){
        guard let keySearch = keySearch.text else {return}
        guard let id = Common.userMaster.id else {return}

        let param = ParamSearch(store_id: id, status: 1, name: keySearch)
        ServiceManager.common.getAllServices(param: "?\(param)"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PServices>().mapArray(JSONObject: response!.data ) ?? [PServices]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        getAllServices()
    }
    
}
