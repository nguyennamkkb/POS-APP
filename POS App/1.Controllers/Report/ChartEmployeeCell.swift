//
//  ChartEmployeeCell.swift
//  POS App
//
//  Created by namnl on 22/07/2023.
//

import UIKit

class ChartEmployeeCell: UITableViewCell {

    @IBOutlet weak var vNhanVien: UIView!
    var returnIdEmployee: ClosureCustom<Int>?
    @IBOutlet var employeeTF: UITextField!
    @IBOutlet var tableView: UITableView!
    var tableData = [ListEmplEach]()
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    var NV = PEmployee()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.registerCells(cells: ["RPEmployeeCell"])
        
        vNhanVien.layer.cornerRadius = myCornerRadius.corner10
        vNhanVien.addNDropShadow()
//        vNhanVien.addBorder(color: myColor.SPA_FE!, width: 0.1)
    }
    func binData(item: [ListEmplEach]){
        tableData = item
        print("ChartEmployeeCell \(tableData.toJSON())")
        let height = 80 * tableData.count
        tableViewHeightConstraint.constant = CGFloat(height)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func EmployeeChanged(_ sender: UITextField) {
        print(sender.text ?? "")
    }
    
}
extension ChartEmployeeCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RPEmployeeCell", for: indexPath) as? RPEmployeeCell else {return UITableViewCell()}
        
        cell.bindData(item: tableData.itemAtIndex(index: indexPath.row) ?? ListEmplEach())
        cell.actionViewList = {
            [weak self] id in
            guard let self = self else {return}
            self.returnIdEmployee?(id)
        }
        return cell
    }
    
    
}
