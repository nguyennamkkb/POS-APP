//
//  ThaoTacVoiDatChoVC.swift
//  LN POS
//
//  Created by Mac mini on 02/05/2024.
//

import UIKit

class ThaoTacVoiDatChoVC: BaseVC {

    @IBOutlet weak var vDaLamXong: UIView!
    @IBOutlet weak var vIn: UIView!
    @IBOutlet weak var vHuy: UIView!
    @IBOutlet weak var vThanhToan: UIView!
    @IBOutlet weak var vSua: UIView!
    @IBOutlet weak var vBatDau: UIView!
    
    var actBatDau: ClosureAction?
    var actSua: ClosureAction?
    var actThanhToan: ClosureAction?
    var actHuy: ClosureAction?
    var actIn: ClosureAction?
    var actDaLamXong: ClosureAction?
    
    var trangThaiLamViec: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        hienThiNut()
    }
    func setupUI(){
        vBatDau.layer.cornerRadius = myCornerRadius.corner10
        vThanhToan.layer.cornerRadius = myCornerRadius.corner10
        vSua.layer.cornerRadius = myCornerRadius.corner10
        vHuy.layer.cornerRadius = myCornerRadius.corner10
        vIn.layer.cornerRadius = myCornerRadius.corner10
        vDaLamXong.layer.cornerRadius = myCornerRadius.corner10
        
    }
    @IBAction func btnDaLamXongPressed(_ sender: Any) {
        onBackNav()
        actDaLamXong?()

    }
    @IBAction func btnInPressed(_ sender: Any) {
        onBackNav()
        actIn?()

    }
    func bindData(trangThai: Int){
        trangThaiLamViec = trangThai
    }
    @IBAction func btnHuyPressed(_ sender: Any) {
        onBackNav()
        actHuy?()

    }
    @IBAction func btnThanhToanPressed(_ sender: Any) {
        onBackNav()
        actThanhToan?()

    }
    
    @IBAction func btnSuaPressed(_ sender: Any) {
        onBackNav()
        actSua?()
       
    }
    @IBAction func btnBatDauPressed(_ sender: Any) {
        onBackNav()
        actBatDau?()
        
    }
    
    
    
    func hienThiNut(){
        vBatDau.isHidden = true
        vSua.isHidden = true
        vHuy.isHidden = true
        vThanhToan.isHidden = true
        vIn.isHidden = true
        vDaLamXong.isHidden = true
        switch trangThaiLamViec {
        case 0:
            
            vBatDau.isHidden = false
            vSua.isHidden = false
            vHuy.isHidden = false

            
//            lbTrangThai.text = "Đang chờ"
//            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            
        case 1:
            vIn.isHidden = false

            
            
//            lbTrangThai.text = "Hoàn thành"
//            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            break
        case 2:

            vSua.isHidden = false
            vHuy.isHidden = false
            vThanhToan.isHidden = false
            vIn.isHidden = false
//            lbTrangThai.text = "Tính tiền"
//            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            break
        case 3:
            vSua.isHidden = false
            vHuy.isHidden = false
            vIn.isHidden = false
            vDaLamXong.isHidden = false

//            lbTrangThai.text = "Đang thực hiện"
//            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            break
            
        default: break
//            lbTrangThai.text = "Đang chờ"
//            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
        }
    }

}
