//
//  RPListInfoVC.swift
//  LN POS
//
//  Created by namnl on 05/08/2023.
//

import UIKit
import ObjectMapper

class RPListInfoVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    var tableData = [PBookCalender]()
    var paramSearch = ParamSearchBook(store_id: Common.userMaster.id ?? 0)
    var timeFrom: Int64?
    var timeTo: Int64?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "LichSuCell")
        getBooks()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func bindData(timeFrom: Int64, timeTo: Int64, idEmployee: Int? = nil){
        paramSearch.status = 1
        paramSearch.from = timeFrom
        paramSearch.to = timeTo
        if let idEmployee = idEmployee {
            paramSearch.idEmployee = idEmployee
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LichSuCell", for: indexPath) as? LichSuCell else {return UITableViewCell()}
        let item = tableData[indexPath.row]
        cell.bindData(e: item)
//        cell.actionDetail = {
//            [weak self] book in
//            guard let self = self else {return}
//            let vc = DetailCalenderVC()
//            vc.bindData(item: book)
//            self.pushVC(controller: vc)
//        }
        return cell
    }
    
    func getBooks(){
        self.showLoading()
        ServiceManager.common.getAllBooks(param: "?\(Utility.getParamFromDirectory(item: paramSearch.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PBookCalender>().mapArray(JSONObject: response!.data ) ?? [PBookCalender]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showMessagError()
            }
        }
        self.hideLoading()
    }
}
