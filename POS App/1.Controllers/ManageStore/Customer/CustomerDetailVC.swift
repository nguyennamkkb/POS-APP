//
//  CustomerDetailVC.swift
//  POS App
//
//  Created by namnl on 25/06/2023.
//

import UIKit
import ObjectMapper

class CustomerDetailVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    
    var deleteSuccess: ClosureAction?
    
    
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var QRImage: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    var customer = PCustomer()
    var customerServices = [PBookCalender]()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "CustomerServicesCell")
        getBooks()
    }
    
    func setupUI(){
        cardView.layer.cornerRadius = myCornerRadius.corner10
        QRImage.layer.cornerRadius = myCornerRadius.corner10
        btnDelete.layer.cornerRadius = myCornerRadius.corner5
        btnEdit.layer.cornerRadius = myCornerRadius.corner5
    }
    func setData(){
        nameLbl.text = "\(customer.fullName ?? "")"
        birthdayLbl.text = "Ngày sinh: \(Common.convertTimestampToDate(timestampString: customer.birthday ?? "", dateFormat: "dd-MM-yyyy"))"
        addressLbl.text = "\(customer.address ?? "")"
        genderLbl.text = "Giới tính: \(customer.gender == 1 ? "Nam" : "Nữ")"
        pointLbl.text = "Điểm: \(customer.loyalty ?? 0)"
        phoneLbl.text = "Điện thoại: \(customer.phone ?? "")"
    }
    func bindData(item: PCustomer){
        customer = item
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnEditPressed(_ sender: UIButton) {
        let vc = CreateCustomerVC()
        vc.bindDataEdit(item: customer)
        vc.actionUpdateOK = {
            [weak self] item in
            guard let self = self else {return}
            self.customer = item
            self.setData()
        }
        self.pushVC(controller: vc)
    }
    
    @IBAction func btnDeletePressed(_ sender: UIButton) {
        customer.status = 0
        customer.sign()
        ServiceManager.common.updateCustomer(param: customer){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.deleteSuccess?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Lỗi")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerServicesCell", for: indexPath) as? CustomerServicesCell else {return UITableViewCell()}
        
        
        let item = customerServices[indexPath.row]
        cell.bindData(item: item)
        return cell
    }
    
    func getBooks(){
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(store_id: id,status: 1)
        ServiceManager.common.getAllBooks(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))&idCustomer=\(customer.id ?? 0)"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.customerServices = Mapper<PBookCalender>().mapArray(JSONObject: response!.data ) ?? [PBookCalender]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showMessagError()
            }
        }
    }
}

