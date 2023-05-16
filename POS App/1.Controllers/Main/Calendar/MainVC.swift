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
//            SideMenuManager.default.leftMenuNavigationController = menu
////            SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
//            SideMenuManager.default.menuPresentMode = .menuSlideIn
//            present(menu, animated: true, completion: nil)
    }
    
    @IBAction func BtnCreateCalenderPressed(_ sender: Any) {
        self.pushVC(controller: CreateCalenderVC())
    }
    
}
