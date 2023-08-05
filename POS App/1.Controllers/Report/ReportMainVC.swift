//
//  ReportMainVC.swift
//  POS App
//
//  Created by namnl on 23/07/2023.
//

import UIKit
import CarbonKit
import ObjectMapper

class ReportMainVC: BaseVC{
    
    
    
    @IBOutlet var tableView: UITableView!
    var timeFrom: Int64?
    var timeTo: Int64?
    var tableData = PReport()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCells(cells: ["RPHeaderCell","ChartDayCell","ChartEmployeeCell"])
        setUpTime()
        getReport()
    }
    
    @IBAction func goHomePressed(_ sender: UIButton) {
        self.wrapRoot(vc: TabBarVC())
    }
    func setUpTime(){
        let currentDate = Common.getCurrentDayMonthYear()
        let from = "1-\(currentDate.month)-\(currentDate.year) 00:00:00"
        let to = "\(currentDate.day)-\(currentDate.month)-\(currentDate.year) 00:00:00"
        if let timeFromMilis = Common.dateStringToMilis(dateString:from) {
            timeFrom = timeFromMilis
//            print(timeFromMilis)
        }
        if var timeToMilis = Common.dateStringToMilis(dateString:to) {
            timeToMilis = timeToMilis + Int64(Common.MillisecondsOfDay)
            timeTo = timeToMilis
//            print(timeToMilis)
        }
        
    }
    func getReport(){
//        guard let keySearch = k   eySearch.text else {return}
        guard let id = Common.userMaster.id else {return}
        guard let from = timeFrom else {return}
        guard let to = timeTo else {return}
        let param = ParamSearch(store_id: id, status: 1,from: from, to: to)
        ServiceManager.common.getReport(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PReport>().map(JSONObject: response!.data ) ?? PReport()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không có dữ liệu")
            }
        }
    }
    
    
}


extension ReportMainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RPHeaderCell", for: indexPath) as? RPHeaderCell else {return UITableViewCell()}
            cell.bindData(money: tableData.totalBook?.money ?? 0, count: tableData.totalBook?.book ?? 0,timeFrom: timeFrom ?? 0, timeTo: timeTo ?? 0)
            cell.fromSelect = {
                [weak self] from in
                guard let self = self else {return}
                print("from\(from)")
                self.timeFrom = from
                self.getReport()
            }
            cell.toSelect = {
                [weak self] to in
                guard let self = self else {return}
                print("to\(to)")
                self.timeTo = to
                self.getReport()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartDayCell", for: indexPath) as? ChartDayCell else {return UITableViewCell()}
            cell.bindData(item: tableData.chartDay ?? [ChartDay]())
            cell.actionViewList = {
                [weak self] timeMilis in
                guard let self = self else {return}
                let vc = RPListInfoVC()
                vc.bindData(timeFrom: timeMilis, timeTo: (timeMilis + Common.MillisecondsOfDay))
                self.pushVC(controller: vc)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartEmployeeCell", for: indexPath) as? ChartEmployeeCell else {return UITableViewCell()}
            cell.binData(item: tableData.listEmplEach ?? [ListEmplEach]())
            cell.returnIdEmployee = {
                [weak self] id in
                guard let self = self else {return}
                let vc = RPListInfoVC()
                vc.bindData(timeFrom: timeFrom ?? 0, timeTo: timeTo ?? 0, idEmployee: id)
                self.pushVC(controller: vc)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

}

