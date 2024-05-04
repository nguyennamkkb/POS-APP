//
//  LichSuDichVuVC.swift
//  LN POS
//
//  Created by Mac mini on 03/05/2024.
//

import UIKit
import ObjectMapper

class LichSuDichVuVC: BaseVC {

    @IBOutlet weak var dpDenNgay: UIDatePicker!
    @IBOutlet weak var dpTuNgay: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    let paramSearch:  ParamSearch = ParamSearch(store_id: Common.userMaster.id ?? -1)
    var tableData = [PBookCalender]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func setupUI(){
        tableView.dataSource = self
        tableView.delegate =  self
        self.tableView.registerCell(nibName: "ItemServicesCell")
    }

    @IBAction func chonDenNgay(_ sender: Any) {
        getBooks()
    }
    @IBAction func chonTuNgay(_ sender: Any) {
        getBooks()
    }
    func getBooks(){
        paramSearch.from = dpTuNgay.date.millisecondsSince1970
        paramSearch.to = dpDenNgay.date.millisecondsSince1970 + 86400000 - 1
        ServiceManager.common.getAllBooks(param: "?\(Utility.getParamFromDirectory(item: paramSearch.toJSON()))"){
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

extension LichSuDichVuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {return UITableViewCell()}
        
        let item = tableData.itemAtIndex(index: indexPath.row) ?? PBookCalender()
        return cell
    }
    
    
}
