//
//  LoiNhanVC.swift
//  LN POS
//
//  Created by Mac mini on 25/04/2024.
//

import UIKit

class LoiNhanVC: UIViewController {

    @IBOutlet weak var lbLoiNhan: UILabel!
    @IBOutlet weak var vLoiNhan: UIView!
    var loiNhan: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        vLoiNhan.layer.cornerRadius = myCornerRadius.corner20
        
//        setupData()
        
    }
    
    func setupData(){
//        lbLoiNhan.text = loiNhan
    }
    @IBAction func dongPressed(_ sender: Any) {
        dong()
    }
    func dong(){
        dismiss(animated: false)
    }
    func bindData(s: String){
        loiNhan = s
        DispatchQueue.main.async { // Sử dụng DispatchQueue.main.async
               self.lbLoiNhan.text = self.loiNhan // Cập nhật UI trong block async
       }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dong()
        }
    
     
    }
    
}
