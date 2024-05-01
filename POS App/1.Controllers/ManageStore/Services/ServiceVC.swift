//
//  ServiceVC.swift
//  POS App
//
//  Created by namnl on 14/06/2023.
//

import UIKit
import ObjectMapper

class ServiceVC:BaseVC  {
    
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var keySearch: UITextField!
    @IBOutlet weak var btnThemMoi: UIButton!
    @IBOutlet weak var vTimKiem: UIView!
    @IBOutlet weak var tableView: UITableView!
    var tableData: [PServices] = [PServices]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "ServiceItemCell")
 
        getAllServices()

    }
    
    func  setupUI(){
        vTimKiem.layer.cornerRadius = myCornerRadius.corner10
        btnThemMoi.layer.cornerRadius = myCornerRadius.corner10

        vTimKiem.addBorder(color: myColor.SPA_FE!, width: 1)
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @objc func loadData() {
        getAllServices()
        refreshControl.endRefreshing()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func timkiem(_ sender: Any) {
        getAllServices()
    }
    
    @IBAction func btnThemDichVuPressed(_ sender: Any) {
        let vc = CreateServiceVC()
        vc.actionOk = {
            [weak self] in
           guard let self = self else {return}
            self.hienThiThongBao(trangThai: 1, loiNhan: "Thành công")
           self.getAllServices()
        }
        self.pushVC(controller: vc)
    }
    
    
    func getAllServices(){
        guard let id = Common.userMaster.id else {return}

        let param = ParamSearch(store_id: id, status: 1, name: keySearch.text ?? "")
        
        ServiceManager.common.getAllServices(param: "?\(Utility.getParamFromDirectory(item: param.toJSON())))"){
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
    @IBAction func btnGoHomepressed(_ sender: UIButton) {
        self.wrapRoot(vc: TabBarVC())
    }
    
}

extension ServiceVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceItemCell", for: indexPath) as? ServiceItemCell else {return UITableViewCell()}
        let item = tableData.itemAtIndex(index: indexPath.row) ?? PServices()
        cell.bindData(e: item)
        cell.actChonDichVu = {
            [weak self] in
            guard let self = self else {return}

            let vc = CreateServiceVC()
            vc.bindDataSua(e: item)
            vc.actXoa = {
                [weak self] in
                guard let self = self else {return}
                self.hienThiThongBao(trangThai: 1, loiNhan: "")
                self.getAllServices()
            }
            vc.actionCapNhatOK = {
                [weak self] in
                guard let self = self else {return}
                self.hienThiThongBao(trangThai: 1, loiNhan: "")
                self.getAllServices()
            }
            self.pushVC(controller: vc)
        }
        return cell
    }
    
    
}
