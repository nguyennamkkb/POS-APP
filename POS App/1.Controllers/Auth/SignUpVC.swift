//
//  SignUpVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class SignUpVC: BaseVC {

    @IBOutlet var xacNhanBtn: UIButton!
    @IBOutlet var noteView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    func setupUI(){
        noteView.layer.cornerRadius = myCornerRadius.corner10
        xacNhanBtn.layer.cornerRadius = myCornerRadius.corner10
    }

    @IBAction func xacNhanPressed(_ sender: UIButton) {
        self.pushVC(controller: TabBarVC())
    }
    
}
