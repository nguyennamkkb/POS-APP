//
//  CreateInfoVC.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit 

class CreateInfoVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    var storeData = PStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "StoreInfoCell")
//        let nib = UINib(nibName: "StoreInfoCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "StoreInfoCell")
    }
    
    func bindData(item:PStore){
        storeData = item
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreInfoCell", for: indexPath) as? StoreInfoCell else {return UITableViewCell()}
        cell.bindData(item: storeData)
        cell.actionSuccess = {
            [weak self] item in
            guard let self = self else {return}
            self.storeData = item
            self.showLoading()
            ServiceManager.common.createStoreMain(param: self.storeData){
                (response) in
                self.hideLoading()
                if response != nil {
                    CacheManager.share.setRegister(true)
                    let vc = LoginVC()
                    vc.bindData(item: self.storeData)
                    self.pushVC(controller: vc)
                } else {
                }
            }
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
