//
//  CustomerVC.swift
//  POS App
//
//  Created by namnl on 04/06/2023.
//

import UIKit
import ObjectMapper

class CustomerVC: BaseVC {

    let refreshControl = UIRefreshControl()
    var tableData: [PCustomer] = [PCustomer]()
    @IBOutlet weak var keySearch: UITextField!
    @IBOutlet weak var bntThemMoi: UIButton!
    @IBOutlet weak var vTimKien: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "CustomerItemCell")
        // Do any additional setup after loading the view.
        setupUI()

    }
    func setupUI(){
        bntThemMoi.layer.cornerRadius = myCornerRadius.corner10
        vTimKien.layer.cornerRadius = myCornerRadius.corner10
        vTimKien.addBorder(color: myColor.SPA_FE!, width: 1)
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnThemMoiPressed(_ sender: Any) {
        let vc = CreateCustomerVC()
        vc.actionOk = {
            [weak self] in
           guard let self = self else {return}
            self.hienThiThongBao(trangThai: 1, loiNhan: "Thành công")
           self.getAllCustomers()
        }
        self.pushVC(controller: vc)

    }
    
    func getAllCustomers(){
        guard let id = Common.userMaster.id else {return}

        let param = ParamSearch(store_id: id, status: 1, keySearch: keySearch.text ?? "")

        ServiceManager.common.getAllCustomers(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PCustomer>().mapArray(JSONObject: response!.data ) ?? [PCustomer]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại mạng hoặc mở lại ứng dụng")
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        getAllCustomers()
    }
    @IBAction func nhapTimKiem(_ sender: Any) {
        getAllCustomers()
    }
    
    @objc func loadData() {
        getAllCustomers()
        refreshControl.endRefreshing()
    }
    
    @IBAction func veTrangChu(_ sender: Any) {
        let vc = CustomerDetailVC()
        self.pushVC(controller: vc)
    }
    
 

}
extension CustomerVC:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerItemCell", for: indexPath) as? CustomerItemCell else {return UITableViewCell()}
        let item =  tableData.itemAtIndex(index: indexPath.row) ?? PCustomer()
        cell.bindData(e: item)
        cell.actChonKhachHang = {
            [weak self] in
            guard let self = self else {return}

            let vc = CustomerDetailVC()
            vc.bindData(e: item)
            vc.actXoa = {
                [weak self] in
                guard let self = self else {return}
                self.hienThiThongBao(trangThai: 1, loiNhan: "")
                self.getAllCustomers()
            }
            self.pushVC(controller: vc)
        }
        
        return cell
    }
    
    
}
