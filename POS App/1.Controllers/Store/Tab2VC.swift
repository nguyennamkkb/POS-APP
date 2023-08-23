//
//  Tab2VC.swift
//  LN POS
//
//  Created by namnl on 19/08/2023.
//

import UIKit
import XLPagerTabStrip

class Tab2VC: UIViewController,IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
           return IndicatorInfo(title: "Tab two")
        
       }

    @IBAction func sad(_ sender: Any) {
        print("2")
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
