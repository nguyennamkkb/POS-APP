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
        mainNavi.tabBarItem = UITabBarItem(title: "Đặt lịch", image: UIImage(systemName: "calendar"), tag: 1)
        mainNavi.tabBarItem.badgeColor = UIColor.white
        
        
        let QRVC = QRVC()
        let QRNavi = UINavigationController(rootViewController: QRVC)
        QRNavi.tabBarItem = UITabBarItem(title: "Quét", image: UIImage(systemName: "qrcode"), tag: 2)
        QRNavi.navigationBar.tintColor = UIColor.white
        
        let store = StoreMainVC()
        let storeNavi = UINavigationController(rootViewController: store)
        storeNavi.tabBarItem = UITabBarItem(title: "Cửa hàng", image: UIImage(systemName: "house"), tag: 3)
        
        self.viewControllers = [mainNavi, QRNavi, storeNavi]
        setLayout()
    }
    func setLayout(){
        tabBar.tintColor = myColor.MBlue
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
