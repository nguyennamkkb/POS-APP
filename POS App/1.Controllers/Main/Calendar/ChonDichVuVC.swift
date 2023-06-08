//
//  ChonDichVuVC.swift
//  POS App
//
//  Created by namnl on 06/06/2023.
//

import UIKit
import ObjectMapper

class ChonDichVuVC: BaseVC, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var tableView: UITableView!
    var tableData = [PServices]()
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
            print("index \(index), status \(status)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return cell
    }

    func getAllServices(){
        guard let id = Common.userMaster.id else {return}
        
        let param: String = "store_id=\(id)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        ServiceManager.common.getAllServices(param: "?\(param)"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PServices>().mapArray(JSONObject: response!.data ) ?? [PServices]()
                self.changeStatus()
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
        print("asdasdas \(tableData.toJSON())")
        for i in 0...tableData.count-1 {
            tableData[i].status = 0
        }
    }
    
    @IBAction func btnOkPressed(_ sender: UIButton) {
        self.onBackNav()
    }
}
