//
//  DangPhucVuVC.swift
//  LN POS
//
//  Created by Mac mini on 24/04/2024.
//

import UIKit
import FittedSheets
import ObjectMapper

class DangPhucVuVC: BaseVC {
    
    let refreshControl = UIRefreshControl()
    
    var paramSearch = ParamSearchBook(store_id: Common.userMaster.id ?? 0)
    var tableData = [PBookCalender]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "MainCell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        getBookDangPhucVu()

    }
    @objc func loadData() {
        getBookDangPhucVu()
        refreshControl.endRefreshing()
    }
    func capNhatDatLich(item: PBookCalender){
        item.sign()
        ServiceManager.common.editBook(param: item){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                
                self.hienThiThongBao(trangThai: 1, loiNhan: "Cập nhật trạng thái thành công")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Cập nhật trạng thái thất bại")
            }
        }
    }

    func xoaDatLich(id: Int){
        let param = ParamSearch(store_id: id)
        ServiceManager.common.deleteBook(param: "\(id)?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "Xoá thành công")
                self.getBookDangPhucVu()
               
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Không thể xoá")
            }
        }
    }
    func getBookDangPhucVu(){
        ServiceManager.common.getAllBookDangPhucVu(param: "?\(Utility.getParamFromDirectory(item: paramSearch.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PBookCalender>().mapArray(JSONObject: response!.data ) ?? [PBookCalender]()
//                self.countPending.text = "Có \(response?.meta?.totalCount ?? 0) lượt chưa hoàn thành."
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showMessagError()
            }
        }
    }
}

extension DangPhucVuVC:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {return UITableViewCell()}
        
        let item = tableData.itemAtIndex(index: indexPath.row) ?? PBookCalender()
        cell.bindData(e: item)
        cell.actThaoTac = {
            [weak self] in
            guard let self = self else {return}
            let vc = ThaoTacVoiDatChoVC()
            
            vc.bindData(trangThai: item.status ?? 0)
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(320)])
            self.present(sheet, animated: true)
            vc.actBatDau = {
                [weak self] in
                guard let self = self else {return}
                
                
                let xacNhan = DemNguocHanhDongVC()
                xacNhan.bindData(s: "Băt đầu làm dịch vụ")
                xacNhan.modalPresentationStyle = .overCurrentContext
                xacNhan.modalTransitionStyle = .crossDissolve
                
                self.present(xacNhan, animated: true)
                xacNhan.actOK = {
                    item.status = 3
                    self.capNhatDatLich(item: item)
                }
            }
            
            vc.actDaLamXong = {
                [weak self] in
                guard let self = self else {return}
                
                
                let xacNhan = DemNguocHanhDongVC()
                xacNhan.bindData(s: "Đã làm xong dịch vụ")
                xacNhan.modalPresentationStyle = .overCurrentContext
                xacNhan.modalTransitionStyle = .crossDissolve
                
                self.present(xacNhan, animated: true)
                xacNhan.actOK = {
                    item.status = 2
                    self.capNhatDatLich(item: item)
                }
            }
            vc.actHuy = {
                [weak self] in
                guard let self = self else {return}
                
                
                let xacNhan = DemNguocHanhDongVC()
                xacNhan.bindData(s: "Huỷ dịch vụ này")
                xacNhan.modalPresentationStyle = .overCurrentContext
                xacNhan.modalTransitionStyle = .crossDissolve
                
                self.present(xacNhan, animated: true)
                xacNhan.actOK = {
                    item.status = 4
                    self.xoaDatLich(id: item.id ?? -1)
        
                }
            }
            
            
            vc.actSua = {
                [weak self]  in
                guard let self = self else {return}
                let vc = CreateCalenderVC()
                vc.bindDataSua(e: item)
                vc.actCapNhatThanhCong = {
                    [weak self] in
                    guard let self = self else {return}
                    self.getBookDangPhucVu()
                }
                self.pushVC(controller: vc)
    //            self.showMessageDeveloping()
            }
            vc.actThanhToan = {
                [weak self] in
                guard let self = self else {return}
                
                
                let xacNhan = DemNguocHanhDongVC()
                xacNhan.bindData(s: "Đã thanh toán dịch vụ")
                xacNhan.modalPresentationStyle = .overCurrentContext
                xacNhan.modalTransitionStyle = .crossDissolve
                
                self.present(xacNhan, animated: true)
                xacNhan.actOK = {
                    item.status = 1
                    self.capNhatDatLich(item: item)
                    self.getBookDangPhucVu()
                }
            }
            
        }
        return cell
        
    }
    
    
}
