//
//  ForgetPasswordVC.swift
//  LN POS
//
//  Created by Mac mini on 23/04/2024.
//

import UIKit

class ForgetPasswordVC: BaseVC {

    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var btnGuiEmail: UIButton!
    @IBOutlet weak var vForm: UIView!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfOTP: UITextField!
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vPass: UIView!
    @IBOutlet weak var vOTP: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    @IBAction func btnGuiEmailPressed(_ sender: Any) {
        guard let email = tfEmail.text, email.count > 5 else {
            self.hienThiLoiNhan(s: "Hãy điền email trước")
            return
        }
        let param = PStore()
        param.email = email
        ServiceManager.common.sendOtp(param: param){
            (response) in
            self.hideLoading()
            if response?.statusCode == 199 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "Đã gửi OTP vào email")
            } else {
                self.showAlert(message: response?.message ?? "")
            }
        }
    }
    
    func setupUI(){
        btnGuiEmail.layer.cornerRadius = myCornerRadius.corner10
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        vForm.layer.cornerRadius = myCornerRadius.corner20
        vEmail.layer.cornerRadius = myCornerRadius.corner10
        vOTP.layer.cornerRadius = myCornerRadius.corner10
        vPass.layer.cornerRadius = myCornerRadius.corner10
        vEmail.addBorder(color: myColor.SPA_FE!, width: 1)
        vOTP.addBorder(color: myColor.SPA_FE!, width: 1)
        vPass.addBorder(color: myColor.SPA_FE!, width: 1)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        guard let email = tfEmail.text, email.count > 5 else {
            self.hienThiLoiNhan(s: "Hãy nhập đủ thông tin")
            return
        }
        guard let otp = tfOTP.text, otp.count == 6 else {
            self.hienThiLoiNhan(s: "Hãy nhập đủ thông tin")

            return
        }
        guard let matKhau = tfPassword.text, matKhau.count > 0 else {
            self.hienThiLoiNhan(s: "Hãy nhập đủ thông tin")

            return
        }
        let param = PStore()
        param.email = email
        param.otp = otp
        param.password = matKhau
        ServiceManager.common.verifyChangePassword(param: param){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "Tạo mật khẩu thành công")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.wrapRoot(vc: LoginVC())
                }
               
            } else {
                self.showAlert(message: response?.message ?? "")
            }
        }
    }
    
}
