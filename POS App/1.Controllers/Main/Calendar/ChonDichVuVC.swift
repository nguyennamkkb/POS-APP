//
//  ChonDichVuVC.swift
//  POS App
//
//  Created by namnl on 06/06/2023.
//

import UIKit
import ObjectMapper

class ChonDichVuVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var amountLbl: UILabel!
    var returnDataSelected: ClosureCustom<[PServices]>?
    @IBOutlet var tableView: UITableView!
    var tableData = [PServices]()
    var listSelected = [PServices]()
    //    var listSelected = [PServices]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "ChonDichVuCell")
        getAllServices()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChonDichVuCell", for: indexPath) as? ChonDichVuCell else {return UITableViewCell()}
        
        cell.bindData(item: tableData[indexPath.row], index: indexPath.row )
        cell.Checked = {
            [weak self] status, index in
            guard let self =  self else  {return}
            self.tableData[index].status = status
            //            print("index \(index), status \(status)")
            self.updateAmount()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    func getAllServices() {
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(store_id: id, status: 1)
        ServiceManager.common.getAllServices(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PServices>().mapArray(JSONObject: response!.data ) ?? [PServices]()
                self.changeStatus()
                self.updateAmount()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể lấy dữ liệu")
            }
        }
    }
    @IBAction func XemDaChonPressed(_ sender: UIButton) {
        print(tableData.toJSON())
    }
    func changeStatus(){
        if tableData.count >= 1 {
            for i in 0...tableData.count-1 {
                tableData[i].status = 0
                if listSelected.count > 0 {
                    for j in 0...listSelected.count-1 {
                        if tableData[i].id == listSelected[j].id {
                            tableData[i].status = 1
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnOkPressed(_ sender: UIButton) {
        //        self.onBackNav()
        getDataSelected()
        
    }
    func getDataSelected(){
        let filtered = tableData.filter { $0.status == 1 }
        print(filtered.toJSON())
        returnDataSelected?(filtered)
        self.onBackNav()
        
    }
    func updateAmount(){
        let filtered = tableData.filter { $0.status == 1 }
        var amount: Int = 0
        for item in filtered {
            if item.status == 1{
                amount += item.price ?? 0
            }
        }
        amountLbl.text = String(amount).currencyFormatting()
    }
    func bindData(listItem: [PServices]){
        listSelected = listItem
    }
}
