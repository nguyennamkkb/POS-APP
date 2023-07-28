//
//  ChartEmployeeCell.swift
//  POS App
//
//  Created by namnl on 22/07/2023.
//

import UIKit

class ChartEmployeeCell: UITableViewCell {

    @IBOutlet var employeeTF: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    var NV = PEmployee()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.delegate = self
        tableView.dataSource = self
        let height = 70 * 2
        tableViewHeightConstraint.constant = CGFloat(height)
        self.tableView.registerCells(cells: ["RPEmployeeCell"])
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RPEmployeeCell", for: indexPath) as? RPEmployeeCell else {return UITableViewCell()}
        return cell
    }
    
    
}
