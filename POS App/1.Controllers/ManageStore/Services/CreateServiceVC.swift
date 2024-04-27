//
//  CreateServiceVC.swift
//  POS App
//
//  Created by namnl on 15/06/2023.
//

import UIKit

class CreateServiceVC: BaseVC{

    @IBOutlet weak var lbTieuDe: UILabel!
    @IBOutlet weak var btnXoa: UIButton!
    var actionOk: ClosureAction?
    var actionCapNhatOK: ClosureAction?
    var actXoa: ClosureAction?
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var trangThaiSua: Int = 0
    var services: PServices = PServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "CreateServiceCell")
        setupUI()

    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        btnXoa.layer.cornerRadius = myCornerRadius.corner10
        btnXoa.addNDropShadow()
        if trangThaiSua == 1 {
            btnXoa.isHidden = false
            lbTieuDe.text = "Sửa dịch vụ"
        }else {
            btnXoa.isHidden = true
            lbTieuDe.text = "Thêm dịch vụ"
        }
        
    }
    func bindDataSua(e: PServices){
        services = e
        trangThaiSua = 1

    }
    @IBAction func btnThemMoiPressed(_ sender: Any) {
        print(services.toJSON())
        
        var trangThaiLoi: Int = 1
        if services.name == nil || services.name?.count == 0 {
            print("name")
            trangThaiLoi = 0
        }
        
        if   services.price == nil {
            print("price")
            trangThaiLoi = 0
        }
        if   services.point == nil{
            print("point")
            trangThaiLoi = 0
        }
     
    
        if trangThaiLoi == 0 {
            hienThiLoiNhan(s: "Hãy điền đủ thông tin")
            return
        }
        services.store_id =  Common.userMaster.id ?? -1
        
        if trangThaiSua == 1 {
            updateServices()
        }else {
            createServices()
        }
    }
    @IBAction func btnXoaPressed(_ sender: Any) {
        let act = XacNhanVC()
        act.bindData(s: "Đồng ý  \(services.name ?? "")")
        act.modalPresentationStyle = .overCurrentContext
        act.modalTransitionStyle = .crossDissolve
        act.actDongY = {
            [weak self] in
            guard let self = self else {return}
            self.xoaDichVu()
        }
        present(act, animated: false, completion: nil)
    }
    
    func createServices(){
        services.sign()
        ServiceManager.common.createService(param: services){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.onBackNav()
                self.actionOk?()
            } else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Hãy kiẻm tra thông tin nhập hoặc mạng")
            }
        }
    }
    func updateServices(){
        services.sign()
        ServiceManager.common.updateServices(param: services){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                    self.onBackNav()
                    self.actionCapNhatOK?()
                }
            } else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Hãy kiẻm tra thông tin nhập hoặc mạng")
            }
        }
    }

    func xoaDichVu(){
        services.status = 0
        services.sign()
        ServiceManager.common.updateServices(param: services){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {

                self.onBackNav()
                self.actXoa?()
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Không thể xoá")
            }
        }
    }
    
}

extension CreateServiceVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateServiceCell", for: indexPath) as? CreateServiceCell else {return UITableViewCell()}
        cell.bindData(e: services)
        return cell
    }
    
    
}
