//
//  TabBarVC.swift
//  POS App
//
//  Created by namnl on 27/04/2023.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainVC = MainVC()
        let mainNavi = UINavigationController(rootViewController: mainVC)
        mainNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_main"), tag: 1)
        
        
        let QRVC = QRVC()
        let QRNavi = UINavigationController(rootViewController: QRVC)
        QRNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_qr"), tag: 2)
        
        
        let payVC = PayVC()
        let payNavi = UINavigationController(rootViewController: payVC)
        payNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_pay"), tag: 3)
        
        self.viewControllers = [mainNavi, QRNavi, payNavi]
        setLayout()
    }
    func setLayout(){
        tabBar.tintColor = UIColor(hex: "#1A72DD")
        tabBar.backgroundColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
