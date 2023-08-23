//
//  MMMVC.swift
//  LN POS
//
//  Created by namnl on 19/08/2023.
//

import UIKit

class MMMVC: UIViewController {

    @IBOutlet var tabView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarController = TestTabsVC()
        addChild(tabBarController)
        tabView.addSubview(tabBarController.view)
        tabBarController.view.frame = tabView.bounds
        tabBarController.didMove(toParent: self)


    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: false)
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
