//
//  SlideMenuVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit
import ObjectMapper

class SlideMenuVC: BaseVC {

    @IBOutlet var storeNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    func setupUI(){
        storeNameLbl.text = Common.userMaster.storeName ?? "MyNameStore"
    }

    @IBAction func bntBaoCaoPressed(_ sender: UIButton) {
        let vc = ReportMainVC()
        let navi = UINavigationController(rootViewController: vc)
        self.wrapRoot(vc: navi)
    }
    @IBAction func bntQuanLyPressed(_ sender: UIButton) {
        let navi = UINavigationController(rootViewController: ManageStoreVC())
        self.wrapRoot(vc: navi)
//        self.pushVC(controller: ManageStoreVC(),animation: true)
    }
    @IBAction func btnContactPressed(_ sender: UIButton) {
        let vc = ContactVC()
        let navi = UINavigationController(rootViewController: vc)
        self.wrapRoot(vc: navi)
    }
    
}
