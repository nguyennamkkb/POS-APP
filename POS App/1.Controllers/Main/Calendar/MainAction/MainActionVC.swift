//
//  MainActionVC.swift
//  POS App
//
//  Created by namnl on 10/06/2023.
//

import UIKit

class MainActionVC: BaseVC {

    var actionCancel: ClosureAction?
    var actionOK: ClosureAction?

    @IBOutlet var btnOK: UIButton!
    @IBOutlet var btnCencel: UIButton!
    @IBOutlet var contentLbl: UILabel!
    @IBOutlet var tileLbl: UILabel!
    var actionTitle: String?
    var actionContent: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    func setupUI(){
        btnOK.layer.cornerRadius = myCornerRadius.corner5
        btnCencel.layer.cornerRadius = myCornerRadius.corner5
        
        tileLbl.text = actionTitle ?? "Xác nhận với hành động của bạn"
        contentLbl.text = actionContent ?? "Thông báo"
    }
    
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        actionCancel?()
        self.onBackNav()
    }
    
    @IBAction func btnOKPressed(_ sender: UIButton) {
        actionOK?()
        self.onBackNav()
    }
    func bindData(title: String?, content: String?) {
        actionContent = content
        actionTitle = title
    }

}
