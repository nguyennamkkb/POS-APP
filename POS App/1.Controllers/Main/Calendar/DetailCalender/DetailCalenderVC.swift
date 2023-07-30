//
//  DetailCalenderVC.swift
//  POS App
//
//  Created by namnl on 15/06/2023.
//

import UIKit
import ObjectMapper

class DetailCalenderVC: BaseVC, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var tableView: UITableView!
    var book = PBookCalender()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        self.tableView.registerCell(nibName: "BookHeaderCell")
        self.tableView.registerCell(nibName: "MidBookDetaiCell")
        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnPrintPressed(_ sender: UIButton) {
        self.showAlert(message: "Đang in")
    }
    
    func bindData(item: PBookCalender){
        self.book = item
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookHeaderCell", for: indexPath) as? BookHeaderCell else {return UITableViewCell()}
            cell.bindData(item: book)
            return cell
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MidBookDetaiCell", for: indexPath) as? MidBookDetaiCell else {return UITableViewCell()}
            let listService =  Mapper<PServices>().mapArray(JSONString: book.listService ?? "" )
            
            cell.bindđata(list: listService ?? [PServices]())
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
}
