//
//  BookHistoryVC.swift
//  LN POS
//
//  Created by namnl on 05/08/2023.
//

import UIKit
import FittedSheets
import ObjectMapper

class BookHistoryVC: BaseVC, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnFilter: UIButton!
    var paramSearch = ParamSearchBook(store_id: Common.userMaster.id ?? 0)
    var tableData = [PBookCalender]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "MainCell")
        getBooks()
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        self.onBackNav()
    }
    func setupUI(){

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {return UITableViewCell()}
        let item = tableData[indexPath.row]
//        cell.bindData(item: item)
//        
//        cell.actionDelete = {
//            [weak self] book in
//            guard let self = self else {return}
//            let vc = MActDeleteVC()
//            vc.bindData(item: book)
//            let sheet = SheetViewController(controller: vc, sizes: [.fixed(400)])
//            self.present(sheet, animated: true)
//            vc.actionOK = {
//                [weak self] in
//                guard let self = self else {return}
//                self.getBooks()
//            }
//            
//        }
//        cell.actionSuccess = {
//            [weak self] book in
//            guard let self = self else {return}
//            let vc = MActSuccessVC()
//            vc.bindData(item: book)
//            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
//            self.present(sheet, animated: true)
//            vc.actionOK = {
//                [weak self] in
//                guard let self = self else {return}
//                self.getBooks()
//            }
//        }
//        
//        cell.actionRun = {
//            [weak self] book in
//            guard let self = self else {return}
//            let vc = MainActionVC()
//            vc.bindData(title: "Thông báo!", content: "Bắt đầu làm dịch vụ")
//            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
//            self.present(sheet, animated: true)
//            vc.actionOK = {
//                [weak self] in
//                guard let self = self else {return}
//                book.status  = 3
//                self.editBook(item: book)
//            }
//        }
//        
//        cell.actionEdit = {
//            [weak self] book in
//            guard let self = self else {return}
//            let vc = CreateCalenderVC()
//            vc.bindData(item: book)
//            vc.actionOK = {
//                [weak self] in
//                guard let self = self else {return}
//                self.getBooks()
//            }
//            self.pushVC(controller: vc)
////            self.showMessageDeveloping()
//        }
//        cell.actionPay = {
//            [weak self] book in
//            guard let self = self else {return}
//            let vc = MainActionVC()
//            vc.bindData(title: "Thông báo!", content: "Tiến hanh thanh toán?")
//            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
//            self.present(sheet, animated: true)
//            vc.actionOK = {
//                [weak self] in
//                guard let self = self else {return}
//                book.status  = 1
//                self.editBook(item: book)
//            }
//        }
//        cell.actionDetail = {
//            [weak self] book in
//            guard let self = self else {return}
//            let vc = DetailCalenderVC()
//            vc.bindData(item: book)
//            self.pushVC(controller: vc)
//        }
        return cell
    }
    func getBooks(){
        self.showLoading()
        ServiceManager.common.getAllBooks(param: "?\(Utility.getParamFromDirectory(item: paramSearch.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PBookCalender>().mapArray(JSONObject: response!.data ) ?? [PBookCalender]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showMessagError()
            }
        }
        self.hideLoading()
    }
    func editBook(item: PBookCalender){
        item.sign()
        ServiceManager.common.editBook(param: item){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.getBooks()
            } else if response?.statusCode == 0 {
                self.showMessagError()
            }
        }
    }
   
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        let vc = MainFilterVC()
        //SCREEN_HEIGHT
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(SCREEN_HEIGHT - 44)])
        self.present(sheet, animated: true)
        
        vc.actionFilter = {
            [weak self] item in
            guard let self = self else {return}
            self.paramSearch = item
            print(item.toJSON())
            self.getBooks()
        }
//        self.present(vc, animated: true)
    }
}
