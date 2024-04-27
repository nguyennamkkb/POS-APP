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
        mainNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "calendar"), tag: 1)
        mainNavi.tabBarItem.badgeColor = UIColor.white
        
        
        let dangPhucVuVC = DangPhucVuVC()
        let phucvuNavi = UINavigationController(rootViewController: dangPhucVuVC)
        phucvuNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "calendar"), tag: 2)
        phucvuNavi.navigationBar.tintColor = UIColor.white
        
        let store = StoreMainVC()
        let storeNavi = UINavigationController(rootViewController: store)
        storeNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 3)
        
        self.viewControllers = [mainNavi, phucvuNavi, storeNavi]
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
