//
//  MainVC.swift
//  POS App
//
//  Created by namnl on 27/04/2023.
//

import UIKit

class MainVC: BaseVC {

    
    
    
    
    @IBOutlet var contCartView: UIView!
    @IBOutlet var btnListOrGrid: UIButton!
    @IBOutlet var btnBarcode: UIButton!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var menuView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        menuView.layer.borderWidth = 0.5
//        btnBarcode.layer.borderWidth = 0.5
        btnSearch.layer.borderWidth = 0.5
        btnListOrGrid.layer.borderWidth = 0.5
        
        
        menuView.layer.borderColor = myColor.greyDrak?.cgColor
//        btnBarcode.layer.borderColor = myColor.greyDrak?.cgColor
        btnSearch.layer.borderColor = myColor.greyDrak?.cgColor
        btnListOrGrid.layer.borderColor = myColor.greyDrak?.cgColor
        
        contCartView.layer.cornerRadius = 6
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
