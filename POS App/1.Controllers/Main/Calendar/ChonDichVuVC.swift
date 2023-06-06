//
//  ChonDichVuVC.swift
//  POS App
//
//  Created by namnl on 06/06/2023.
//

import UIKit

class ChonDichVuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var tableView: UITableView!
    var tableData = [PServices]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "ChonDichVuCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChonDichVuCell", for: indexPath) as? ChonDichVuCell else {return UITableViewCell()}
        cell.bindData(item: tableData[indexPath.row])
        return cell
    }
    
    
    
}
