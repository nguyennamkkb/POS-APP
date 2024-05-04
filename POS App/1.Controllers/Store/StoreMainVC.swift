//
//  StoreMainVC.swift
//  POS App
//
//  Created by namnl on 04/08/2023.
//

import UIKit

class StoreMainVC: BaseVC {

    
    @IBOutlet var storeNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func huongDanPressed(_ sender: UIButton) {
        if let url = NSURL(string: "https://docs.google.com/document/d/1hRVQpM--d9jX2UPofP68251YQnPH1nr2dwUBPKZuj4w/edit?usp=sharing"){
            UIApplication.shared.openURL(url as URL)
           }
    }
    
    @IBAction func btnHoaDonPressed(_ sender: Any) {
        let vc =  LichSuDichVuVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnDichVuPressed(_ sender: Any) {
        let vc =  ServiceVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnKhachHangPressed(_ sender: Any) {
        let vc = CustomerVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnNhanVienPressed(_ sender: Any) {
        let vc = EmployeeVC()
        self.pushVC(controller: vc)
    }
    @IBAction func LogoutPressed(_ sender: UIButton) {
        let vc = LoginVC()
        let navi = UINavigationController(rootViewController: vc)
        self.wrapRoot(vc: navi)
    }
    @IBAction func editStorePressed(_ sender: Any) {
        let vc = EditStoreVC()
        self.pushVC(controller: vc)
    }
    @IBAction func CaiDatPressed(_ sender: Any) {
//        let vc = MMMVC()
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//
////        let vc = SettingVC()
////        self.pushVC(controller: vc)
//        present(vc, animated: true, completion: nil)

    }
    
}
