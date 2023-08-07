//
//  EditStoreVC.swift
//  LN POS
//
//  Created by namnl on 07/08/2023.
//

import UIKit

class EditStoreVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "EditStoreCell")
    }

    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
}

extension EditStoreVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditStoreCell", for: indexPath) as? EditStoreCell else {return UITableViewCell()}
       
        return cell
    }

}
