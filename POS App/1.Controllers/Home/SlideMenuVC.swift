//
//  SlideMenuVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class SlideMenuVC: BaseVC {

    @IBOutlet var storeNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func bntBaoCaoPressed(_ sender: UIButton) {
    }
    @IBAction func bntQuanLyPressed(_ sender: UIButton) {
        self.pushVC(controller: ManageStoreVC())
    }
    @IBAction func bntCuaHangPressed(_ sender: UIButton) {
    }
    @IBAction func btnHoTroPressed(_ sender: Any) {
    }
}
