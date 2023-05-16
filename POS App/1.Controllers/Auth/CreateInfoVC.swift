//
//  CreateInfoVC.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit 

class CreateInfoVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "StoreInfoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StoreInfoCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreInfoCell", for: indexPath) as? StoreInfoCell else {return UITableViewCell()}
        cell.actionSuccess = {  [weak self] in
            guard let self = self else { return }
            self.wrapRoot(vc: TabBarVC())
        }
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
