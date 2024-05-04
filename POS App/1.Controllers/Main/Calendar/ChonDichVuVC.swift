//
//  ChonDichVuVC.swift
//  POS App
//
//  Created by namnl on 06/06/2023.
//

import UIKit
import ObjectMapper

class ChonDichVuVC: BaseVC {
    
    let refreshControl = UIRefreshControl()
    var danhSachDaChon: ClosureCustom<[PServices]>?
    var tableData: [PServices] = [PServices]()
    @IBOutlet weak var vTimKiem: UIView!
    @IBOutlet weak var lbTongTien: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnChonDichVu: UIButton!
    
    @IBOutlet weak var keySearch: UITextField!
    var dsGoc = [PServices]()
    
    var daChon: ClosureCustom<[PServices]>?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "ChonDichVuCell")
        setupUI()
        capNhatSoTien()
        
    }
    
    func setupUI(){
        btnChonDichVu.layer.cornerRadius = myCornerRadius.corner10
        vTimKiem.layer.cornerRadius = myCornerRadius.corner10
        vTimKiem.addBorder(color: myColor.SPA_FE!, width: 1)
        
        refreshControl.addTarget(self, action: #selector(taiLai), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func bindData(l: [PServices]){
        tableData = l
        dsGoc = tableData

    }
    @objc func taiLai() {
        for index in 0..<tableData.count {
            
            tableData[index].status = 1
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    @IBAction func timKien(_ sender: Any) {
        print("Tim kiem")
        let tuKhoa = (keySearch.text ?? "").folded.lowercased()
        print(tuKhoa)
        let ds = dsGoc.filter { e in

            if let value = e.name?.folded.lowercased() {
                if tuKhoa.count == 0 {return true}
                return value.contains(tuKhoa)
            }
            return false
        }
        if tuKhoa.count == 0 {
            tableData = dsGoc
        }
//        print(dsGoc.toJSON())
        tableData = ds
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        let filtered = tableData.filter { $0.status == 2 }
        //        print(filtered.toJSON())
        danhSachDaChon?(filtered)
        self.onBackNav()
        
    }

    func getDataSelected(){
        let filtered = tableData.filter { $0.status == 2 }
        //        print(filtered.toJSON())
        danhSachDaChon?(filtered)
        self.onBackNav()
        
    }
    func capNhatSoTien(){
        let filtered = tableData.filter { $0.status == 2 }
        var amount: Int = 0
        for item in filtered {
            if item.status == 2{
                amount += item.price ?? 0
            }
        }
        lbTongTien.text = "\(String(amount).currencyFormatting())đ"
    }
}

extension ChonDichVuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChonDichVuCell", for: indexPath) as? ChonDichVuCell else {return UITableViewCell()}
        let index = indexPath.row
        let item = tableData.itemAtIndex(index: indexPath.row) ?? PServices()
        cell.bindData(item: item, index: index)
        cell.daChon = {
            [weak self] e in
            guard let self =  self else  {return}
            self.tableData[index].status = 2
            //            listSelected.append(e)
            self.capNhatSoTien()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        cell.boChon = {
            [weak self] e in
            guard let self =  self else  {return}
            self.tableData[index].status = 1
            //            listSelected.append(e)
            self.capNhatSoTien()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    
}
