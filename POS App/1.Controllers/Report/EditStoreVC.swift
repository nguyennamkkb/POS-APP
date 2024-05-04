//
//  EditStoreVC.swift
//  LN POS
//
//  Created by namnl on 07/08/2023.
//

import UIKit

class EditStoreVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    var store: PStore = Common.userMaster
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "EditStoreCell")
        
    }

    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func capNhatTaiKhoan(){
        store.sign()
        ServiceManager.common.updateUser(param: store){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "Cập nhật thành công")
                Common.userMaster = self.store
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Hãy kiẻm tra thông tin nhập hoặc mạng!")
            }
        }
    }
    
}

extension EditStoreVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditStoreCell", for: indexPath) as? EditStoreCell else {return UITableViewCell()}
       
        cell.actXacNhan = {
            [weak self] item in
            guard let self = self else {return}
            self.store.storeName = item.storeName
            self.store.phone = item.phone
            self.store.address = item.address
            self.capNhatTaiKhoan()
        }
        return cell
    }

}
