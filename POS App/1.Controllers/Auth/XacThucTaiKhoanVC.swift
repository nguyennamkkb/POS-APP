//
//  XacThucTaiKhoanVC.swift
//  LN POS
//
//  Created by Mac mini on 25/04/2024.
//

import UIKit

class XacThucTaiKhoanVC: BaseVC {

    @IBOutlet weak var tfOTP: UITextField!
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var vOTP: UIView!
    @IBOutlet weak var vForm: UIView!
    var emailInput: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        vForm.layer.cornerRadius = myCornerRadius.corner20
        vOTP.layer.cornerRadius = myCornerRadius.corner10
        vOTP.addBorder(color: myColor.SPA_FE!, width: 1)
       
    }
    func bindData(email: String){
        emailInput = email
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        guard let otp = tfOTP.text, otp.count == 6 else {
            self.hienThiLoiNhan(s: "Mã OTP có 6 ký tự")
            return
        }
        
        let store = PStore(email: emailInput, otp: otp)
        store.sign()
        ServiceManager.common.verifyUser(param: store){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                
                self.hienThiThongBao(trangThai: 1, loiNhan: "Đăng ký thành công, hãy đăng nhập để tiếp tục sử dụng")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1  ) {
                    let vc = LoginVC()
                    vc.bindData(item: store)
                    self.pushVC(controller: vc)
                }
                
                
            } else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Có vẻ OTP không đúng!")
//                self.hienThiLoiNhan(s: "Có thể Email đã được sử dụng")
            }
        }
    }
    


}
