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
    
    @IBAction func LogoutPressed(_ sender: UIButton) {
        let vc = LoginVC()
        self.wrapRoot(vc: vc)
    }
    
}
