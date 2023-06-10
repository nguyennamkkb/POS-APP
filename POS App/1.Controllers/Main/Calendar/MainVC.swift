//
//  MainVC.swift
//  POS App
//
//  Created by namnl on 27/04/2023.
//

import UIKit
import SideMenu
import ObjectMapper
import FittedSheets

class MainVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var taoLichBtn: UIButton!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var menuView: UIView!
    var tableData = [PBookCalender]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "MainCell")
        getBooks()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {return UITableViewCell()}
        let item = tableData[indexPath.row]
        cell.bindData(item: item)
        
        cell.actionDelete = {
            [weak self] book in
            guard let self = self else {return}
            let vc = MActDeleteVC()
            vc.bindData(item: book)
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(400)])
            self.present(sheet, animated: true)
            vc.actionOK = {
                [weak self] in
                guard let self = self else {return}
                self.getBooks()
            }
            
        }
        cell.actionSuccess = {
            [weak self] book in
            guard let self = self else {return}
            let vc = MActSuccessVC()
            vc.bindData(item: book)
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
            self.present(sheet, animated: true)
            vc.actionOK = {
                [weak self] in
                guard let self = self else {return}
                self.getBooks()
            }
        }
        
        cell.actionRun = {
            [weak self] book in
            guard let self = self else {return}
            let vc = MainActionVC()
            vc.bindData(title: "Thông báo!", content: "Bắt đầu làm dịch vụ")
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
            self.present(sheet, animated: true)
            vc.actionOK = {
                [weak self] in
                guard let self = self else {return}
                book.status  = 3
                self.editBook(item: book)
            }
        }
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
        let vc = CreateCalenderVC()
        vc.actionOK = {
            [weak self] in
            guard let self = self else {return}
            self.getBooks()
        }
        self.pushVC(controller: vc)

    }
    
    func getBooks(){
        guard let id = Common.userMaster.id else {return}
        let param: String = "store_id=\(id)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        ServiceManager.common.getAllBooks(param: "?\(param)"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PBookCalender>().mapArray(JSONObject: response!.data ) ?? [PBookCalender]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể lấy dữ liệu")
            }
        }
    }
    func editBook(item: PBookCalender){
        ServiceManager.common.editBook(param: item){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.getBooks()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể sửa")
            }
        }
    }
   
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        
    }
}
