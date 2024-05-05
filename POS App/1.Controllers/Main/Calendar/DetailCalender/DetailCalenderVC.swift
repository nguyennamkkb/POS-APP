//
//  DetailCalenderVC.swift
//  POS App
//
//  Created by namnl on 15/06/2023.
//

import UIKit
import ObjectMapper
import Printer

class DetailCalenderVC: BaseVC, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet var tableView: UITableView!
    var book = PBookCalender()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        self.tableView.registerCell(nibName: "BookHeaderCell")
        self.tableView.registerCell(nibName: "MidBookDetaiCell")
        
        btnIn.layer.cornerRadius = myCornerRadius.corner10
        btnIn.addBorder(color: myColor.SPA_FE!, width: 1)
        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnPrintPressed(_ sender: UIButton) {
        self.showAlert(message: "Đang in")
//        //anh qr
//        let imageViewQR = UIImageView()
//        var resizedImageQR = UIImage(named: "img_qn")!
//        
//        let url: String = ServiceManager.ROOT+"images/viewimage/qr"+String(Common.userMaster.id ?? 1)



//        imageViewQR.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "img_qn"), completionHandler:  { result in
//            switch result {
//            case .success(_):
//                trangThaiTaiAnh = 1
//                print("Tai anh thanh cong")
//                resizedImageQR = imageViewQR.image?.resized(toWidth: 250) ?? UIImage()
//            case .failure(_):
//                print("Lỗi tải ảnh")
//                resizedImageQR = UIImage(named: "img_qn")!.resized(toWidth: 1)
//  
//            }
//        })
//        if trangThaiTaiAnh == 0 {
//            return
//        }
       
        
        
// 
//        guard let resizedImageQR1 = convertImageToBlackAndWhite(inputImage: resizedImageQR ) else {return}
////        guard  let cgImageQR = resizedImageQR1?.reducePixelQuality(quality: 0.9)  else {
//        let cgImageQR = (resizedImageQR1.reducePixelQuality(quality: 0.5))?.cgImage!
//        print("url4",url)
//        
//        
        
//        // anh logo
//        let imageViewLogo = UIImageView()
//        imageViewLogo.kf.setImage(with:URL(string: ServiceManager.ROOT+"images/viewimage/logo"+String(Common.userMaster.id ?? 1)))
//        let resizedImageLogo = imageViewLogo.image?.resized(toWidth: 350)
//        guard let resizedImagelogo = resizedImageLogo else{return}
//        let resizedImagelogo1 = convertImageToBlackAndWhite(inputImage: resizedImagelogo )
////        guard  let cgImageQR = resizedImageQR1?.reducePixelQuality(quality: 0.9)  else {
//        guard  let cgImageLogo = resizedImagelogo1?.reducePixelQuality(quality: 0.1)?.cgImage  else {
//            return
//        }
//
        
        
        //ket thuc
        
        let receipt = Receipt(.init(maxWidthDensity: 380 , fontDensity: 12, encoding: .utf8))
        
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .layout(.justification(.center))
//        <<< ImageItem(cgImageLogo, grayThreshold: 60 )
        <<< CommonPrint.removeVietnameseDiacritics(from: (Common.userMaster.storeName ?? "").uppercased())
        <<~ .page(.printAndFeed(lines: 1))

        <<< CommonPrint.removeVietnameseDiacritics(from: Common.userMaster.address!)
        <<< CommonPrint.removeVietnameseDiacritics(from: "DT: "+Common.userMaster.phone!)
        <<< Dividing.`default`()
        <<< CommonPrint.removeVietnameseDiacritics(from: "THONG TIN DICH VU")

        <<~ .layout(.justification(.left))
//        <<< CommonPrint.removeVietnameseDiacritics(from: book.id == nil ? "": "Số HD: #\(book.id ?? 0)")
        <<< CommonPrint.NamKVItem(left: book.id == nil ? "": "So HD: #\(book.id ?? 0)", right: "Diem: \(layDienDichVu(l: book.listService ?? ""))")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Ngay: \(Common.getDateFormatFromMiliseonds(time:book.start ?? "0"))")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Khách hàng: \(book.customer?.fullName ?? "")")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Nhân viên: \(book.employee?.fullName ?? "")")
     
        <<< Dividing.`default`()
        <<< KVItem("DV", "Thanh tien")
        <<< setLbItem()
        <<< Dividing.`default`()
        <<< CommonPrint.NamKVItem(left: "Tong tien", right: "\(book.amount!)".currencyFormatting())
        <<~ .layout(.justification(.center))
        <<~ .page(.printAndFeed(lines: 1))
//        <<< ImageItem(cgImageQR!, grayThreshold: 100 )
        <<< CommonPrint.removeVietnameseDiacritics(from: "Cam on quy khach!")
        <<~ .page(.printAndFeed(lines: 1))
        
        <<< CommonPrint.removeVietnameseDiacritics(from: "quetnhanh.vn")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Ứng dụng QSalon")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Hỗ trợ Salon, Spa miễn phí")
        
        <<< Command.cursor(.lineFeed)
        <<~ .cursor(.lineFeed)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
    }
    
    func setLbItem() -> String {
        var str: String = ""
        let listItem = Mapper<PServices>().mapArray(JSONString: book.listService ?? "" ) ?? [PServices]()
        for (index,_) in listItem.enumerated() {
            str += ""
//            str += "\(listItem[index].name!)\n"
            str += CommonPrint.NamKVItem(left: "\(listItem[index].name ?? "")", right: "\(listItem[index].price ?? 0)".currencyFormatting())
//            str += "\n"
        }
        return CommonPrint.removeVietnameseDiacritics(from: str)
    }
    func bindData(item: PBookCalender){
        self.book = item
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookHeaderCell", for: indexPath) as? BookHeaderCell else {return UITableViewCell()}
            cell.bindData(item: book)
            return cell
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MidBookDetaiCell", for: indexPath) as? MidBookDetaiCell else {return UITableViewCell()}
            let listService =  Mapper<PServices>().mapArray(JSONString: book.listService ?? "" )
            
            cell.bindđata(list: listService ?? [PServices]())
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func layDienDichVu(l: String) -> Int{
        let listItem = Mapper<PServices>().mapArray(JSONString: l ) ?? [PServices]()
        var tongDiem: Int = 0
        for e in listItem {
            tongDiem += e.point ?? 0
        }
        return tongDiem
    }
    
}
