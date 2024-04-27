//
//  EmployeeVC.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit
import ObjectMapper

class EmployeeVC: BaseVC {
    let refreshControl = UIRefreshControl()
    var tableData: [PEmployee] = [PEmployee]()
    @IBOutlet weak var keySearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bHome: UIButton!
    
    @IBOutlet weak var vTimKiem: UIView!
    @IBOutlet weak var bThemMoi: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "EmployeeItemCell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)

//        getAllEployees()
    }

    override func viewDidAppear(_ animated: Bool) {
        getAllEployees()
    }
    @IBAction func nhapTimKiem(_ sender: Any) {
        getAllEployees()
    }
    func setupUI() {
        bThemMoi.layer.cornerRadius = myCornerRadius.corner10
        vTimKiem.layer.cornerRadius = myCornerRadius.corner10
        vTimKiem.addBorder(color: myColor.SPA_FE!, width: 1)
    }
    @objc func loadData() {
        getAllEployees()
        refreshControl.endRefreshing()
    }
    @IBAction func timNhanVien(_ sender: Any) {
        guard keySearch.text != nil else {return}
        getAllEployees()
    }
    @IBAction func btnThemMoiNhanVienPressed(_ sender: Any) {
        let vc = CreateEmployeeVC()
        vc.actionOK = {
            [weak self] in
           guard let self = self else {return}
            self.hienThiThongBao(trangThai: 1, loiNhan: "Thành công")
           self.getAllEployees()
        }
        self.pushVC(controller: vc)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnGoHomepressed(_ sender: UIButton) {
        self.wrapRoot(vc: TabBarVC())
    }
    
    func getAllEployees(){

        guard let id = Common.userMaster.id else {return}
        
        let param = ParamSearch(store_id: id, status: 1, keySearch: keySearch.text ?? "")

        ServiceManager.common.getAllEmployees(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in

            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PEmployee>().mapArray(JSONObject: response!.data ) ?? [PEmployee]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại mạng hoặc mở lại ứng dụng")
            }
           
        }
    }

    
}

extension EmployeeVC:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeItemCell", for: indexPath) as? EmployeeItemCell else {return UITableViewCell()}
        let item = tableData.itemAtIndex(index: indexPath.row) ?? PEmployee()
        cell.bindData(e:item)
        cell.actChonNhanVien = {
            [weak self] in
           guard let self = self else {return}
            let vc = EmployeeDetailVC()
            vc.bindData(e: item)
            vc.actXoa = {
                [weak self] in
                guard let self = self else {return}
                self.hienThiThongBao(trangThai: 1, loiNhan: "")
                self.getAllEployees()
            }
            self.pushVC(controller: vc)
        }
        
        return cell
    }
    
    
}
