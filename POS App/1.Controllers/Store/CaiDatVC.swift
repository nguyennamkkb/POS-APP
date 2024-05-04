//
//  StoreMainVC.swift
//  POS App
//
//  Created by namnl on 04/08/2023.
//

import UIKit
import Printer

class CaiDatVC: BaseVC {
    private let dummyPrinter = DummyPrinter()
    
    @IBOutlet weak var btnInThu: UIButton!
    @IBOutlet weak var btnDangXuat: UIButton!
    @IBOutlet var storeNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dummyPrinter.ticketRender = self
        btnDangXuat.addBorder(color: myColor.SPA_FE!, width: 1)
        btnInThu.addBorder(color: myColor.SPA_FE!, width: 1)
        
        btnInThu.layer.cornerRadius = myCornerRadius.corner10
        btnDangXuat.layer.cornerRadius = myCornerRadius.corner10
    }
    
    @IBAction func huongDanPressed(_ sender: UIButton) {
        if let url = NSURL(string: "https://docs.google.com/document/d/1hRVQpM--d9jX2UPofP68251YQnPH1nr2dwUBPKZuj4w/edit?usp=sharing"){
            UIApplication.shared.openURL(url as URL)
           }
    }
    @IBAction func btnCuaHangPressed(_ sender: Any) {
        let vc =  EditStoreVC()
        self.pushVC(controller: vc)
    }
    
    @IBAction func btnThongKePressed(_ sender: Any) {
        
        let vc =  ReportMainVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnHoaDonPressed(_ sender: Any) {
        let vc =  LichSuDichVuVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnDichVuPressed(_ sender: Any) {
        let vc =  ServiceVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnKhachHangPressed(_ sender: Any) {
        let vc = CustomerVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnNhanVienPressed(_ sender: Any) {
        let vc = EmployeeVC()
        self.pushVC(controller: vc)
    }
    @IBAction func LogoutPressed(_ sender: UIButton) {
        let vc = LoginVC()
        let navi = UINavigationController(rootViewController: vc)
        self.wrapRoot(vc: navi)
    }
    @IBAction func editStorePressed(_ sender: Any) {
        let vc = EditStoreVC()
        self.pushVC(controller: vc)
    }
    @IBAction func btnChonMayIn(_ sender: Any) {
        let vc = BluetoothPrinterSelectTableViewController()
        vc.bindData(data: bluetoothPrinterManager)
        
        self.pushVC(controller: vc)
    }
    @IBAction func btnInThuPressed(_ sender: Any) {
  
        self.hienThiLoiNhan(s: "Đang in thử")
 
        let receipt = Receipt(.init(maxWidthDensity: 380 , fontDensity: 12, encoding: .utf8))
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .layout(.justification(.center))
        <<~ .layout(.lineSpace(.l1_8))
        <<< CommonPrint.removeVietnameseDiacritics(from: "IN THU")
        <<~ .page(.printAndFeed(lines: 1))
        <<< CommonPrint.removeVietnameseDiacritics(from: "quetnhanh.vn")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Ung dung QSalon")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Quản lý Salon, Spa")
        <<~ .cursor(.lineFeed)
        <<< Command.cursor(.lineFeed)
        <<~ .cursor(.lineFeed)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
    }
    @IBAction func CaiDatPressed(_ sender: Any) {
//        let vc = MMMVC()
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//
////        let vc = SettingVC()
////        self.pushVC(controller: vc)
//        present(vc, animated: true, completion: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BluetoothPrinterSelectTableViewController {
            vc.sectionTitle = "Chọn máy in"
            vc.printerManager = bluetoothPrinterManager
        }
    }
}
extension CaiDatVC: TicketRender {
    func printerDidGenerate(_ printer: DummyPrinter, html htmlTicket: String) {
//        DispatchQueue.main.async { [weak self] in
//            self?.webView.loadHTMLString(htmlTicket, baseURL: nil)
//        }
        //        debugPrint(htmlTicket)
    }
}
        
