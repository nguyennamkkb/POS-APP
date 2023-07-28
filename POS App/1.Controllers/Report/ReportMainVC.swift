//
//  ReportMainVC.swift
//  POS App
//
//  Created by namnl on 23/07/2023.
//

import UIKit
import CarbonKit

class ReportMainVC: BaseVC{
    
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCells(cells: ["RPHeaderCell","ChartDayCell","ChartEmployeeCell"])
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
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartDayCell", for: indexPath) as? ChartDayCell else {return UITableViewCell()}
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartEmployeeCell", for: indexPath) as? ChartEmployeeCell else {return UITableViewCell()}
            return cell
        default:
            return UITableViewCell()
        }
    }
}
