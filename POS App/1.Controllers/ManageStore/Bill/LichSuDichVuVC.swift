//
//  LichSuDichVuVC.swift
//  LN POS
//
//  Created by Mac mini on 03/05/2024.
//

import UIKit
import ObjectMapper

class LichSuDichVuVC: BaseVC {
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var vDenNgay: UIView!
    @IBOutlet weak var vTuNgay: UIView!
    @IBOutlet weak var dpDenNgay: UIDatePicker!
    @IBOutlet weak var dpTuNgay: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    let paramSearch:  ParamSearch = ParamSearch(store_id: Common.userMaster.id ?? -1)
    var tableData: [PBookCalender]  = [PBookCalender]()
    override func viewDidLoad() {
        super.viewDidLoad()

        getBooks()
        setupUI()
    }
    func setupUI(){
        vDenNgay.layer.cornerRadius = myCornerRadius.corner10
        vTuNgay.layer.cornerRadius = myCornerRadius.corner10
        tableView.dataSource = self
        tableView.delegate =  self
        self.tableView.registerCell(nibName: "LichSuCell")
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    @objc func loadData() {
        getBooks()
        refreshControl.endRefreshing()
    }
    @IBAction func backPressed(_ sender: Any) {
        onBackNav()
    }
    @IBAction func chonDenNgay(_ sender: Any) {
        getBooks()
    }
    @IBAction func chonTuNgay(_ sender: Any) {
        getBooks()
    }
    func getBooks(){

        paramSearch.from = Common.layDauNgayMiliseconds(ngay: dpTuNgay.date.millisecondsSince1970)
        paramSearch.to = Common.layCuoiNgayMiliseconds(ngay: dpDenNgay.date.millisecondsSince1970)
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
    }
}

extension LichSuDichVuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count \(tableData.count)")
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LichSuCell", for: indexPath) as? LichSuCell else {return UITableViewCell()}
        
        let item = tableData.itemAtIndex(index: indexPath.row) ?? PBookCalender()
        cell.bindData(e: item)
        
        cell.actXem = {
            [weak self] in
            guard let self = self else {return}
            let vc = DetailCalenderVC()
            vc.bindData(item: item)
            self.pushVC(controller: vc)
        }
        return cell
    }
    
    
}
