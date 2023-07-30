//
//  MidBookDetaiCell.swift
//  POS App
//
//  Created by namnl on 16/06/2023.
//

import UIKit

class MidBookDetaiCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var totalMoneyLbl: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

    var height: Float = 100
    var tableData = [PServices]()
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate =  self
        self.tableView.registerCell(nibName: "ItemServicesCell")

    }

    func bindđata(list: [PServices]){
        self.tableData = list
        height = Float(tableData.count * 30)
        tableViewHeightConstraint.constant = CGFloat(height)
        tableView.layoutIfNeeded()
        totalMoneyLbl.text = "\(String(getTotalMoney(list: list)).currencyFormatting())đ"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemServicesCell", for: indexPath) as? ItemServicesCell else {return UITableViewCell()}
        let item = tableData[indexPath.row]
        cell.bindData(name: item.name ?? "", price: item.price ?? 0)
        return cell
    }
    func getTotalMoney(list: [PServices]) -> Int{
        var total = 0
        for e in list {
            total += e.price ?? 0
        }
        return total
    }
}
