//
//  MainVC.swift
//  POS App
//
//  Created by namnl on 27/04/2023.
//

import UIKit
import SideMenu

class MainVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var taoLichBtn: UIButton!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var menuView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "MainCell")
        //        print(CacheManager.share.getUserMaster())
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {return UITableViewCell()}
        return cell
    }
    
    
    func setupUI(){
        menuView.layer.borderWidth = 0.5
        menuView.layer.borderColor = myColor.greyDrak?.cgColor
        btnSearch.layer.borderColor = myColor.greyDrak?.cgColor
        taoLichBtn.layer.cornerRadius = myCornerRadius.corner5
    }
    
    @IBAction func sideLeftPressed(_ sender: UIButton) {
//        let menu = SideMenuNavigationController(rootViewController: SlideMenuVC())
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: SlideMenuVC())

        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        leftMenuNavigationController.menuWidth = 300
        present(leftMenuNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func BtnCreateCalenderPressed(_ sender: Any) {
        self.pushVC(controller: CreateCalenderVC())
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
