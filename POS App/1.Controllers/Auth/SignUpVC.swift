//
//  SignUpVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit
import ObjectMapper
class SignUpVC: BaseVC {
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet weak var vForm: UIView!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vPass: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        checkData()
    }
    func setupUI(){
        tfPassword.isSecureTextEntry = true
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10

        vForm.layer.cornerRadius = myCornerRadius.corner20
        vEmail.layer.cornerRadius = myCornerRadius.corner10
        vPass.layer.cornerRadius = myCornerRadius.corner10
        vEmail.addBorder(color: myColor.SPA_FE!, width: 1)
        vPass.addBorder(color: myColor.SPA_FE!, width: 1)
        
        tfEmail.text = "nguyennam.kkb@gmail.com"
        tfPassword.text = "123456"
        
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
    
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        view.endEditing(true)
        guard let email = tfEmail.text, email.count >= 6  else {
            print("email")
            self.hienThiLoiNhan(s: "Kiểm tra lại email")
            return}
        guard let password = tfPassword.text, password.count >= 6 else {
            print("pass")
            self.hienThiLoiNhan(s: "Kiểm tra lại mật khẩu")
            return}
        
        self.showLoading()
        let store = PStore(email:email,password: password)
//        let paramRequest = Utility.getParamFromDirectory(item: store.toJSON())
        ServiceManager.common.checkUser(param: store){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                
                self.hienThiThongBao(trangThai: 1, loiNhan: "Hãy thềm thông tin cửa hàng")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1  ) {
                    let vc = CreateInfoVC()
                    vc.bindData(item: store)
                    self.pushVC(controller: vc)
                }
                
              
            } else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Có thể Email đã được sử dụng")
//                self.hienThiLoiNhan(s: "Có thể Email đã được sử dụng")
            }
        }
    }
    
//    @IBAction func xacNhanPressed(_ sender: UIButton) {
//        view.endEditing(true)
//        guard let phone = phoneTF.text else {return}
//        guard let password =  passwordTF.text, password.count >= 6 else {return}
//        self.showLoading()
//        
//        let store = PStore(phone:phone,password: password)
////        let paramRequest = Utility.getParamFromDirectory(item: store.toJSON())
//        ServiceManager.common.checkUser(param: store){
//            (response) in
//            self.hideLoading()
//            if response?.statusCode == 200 {
//                let vc = CreateInfoVC()
//                vc.bindData(item: store)
//                self.pushVC(controller: vc)
//            } else {
//                self.messageLbl.text = "Thông báo: Lỗi đăng ký"
//            }
//        }
//       
//        
//    }
    
//    @IBAction func hideOrShowPassword(_ sender: UIButton) {
//        isShowPassword = !isShowPassword
//        if isShowPassword {
//            btnShowPassword.setImage(UIImage(systemName: "eye"), for: .normal)
//            //code show
//        }else{
//            btnShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
//            //code hide
//        }
//    }
//    
//    @IBAction func dangNhapPressed(_ sender: Any) {
//        self.pushVC(controller: LoginVC())
//    }
//    
//    func checkData(){
////        let store = PStore()
////        store.phone = "0358737373"
////
////        let paramRequest = Utility.getParamFromDirectory(item: store.toJSON())
////        ServiceManager.common.getStoreMain(param: paramRequest){
////            (response) in
////
////           
////            if response != nil {
////    
////                self.messageLbl.text = "Thông báo: Số điện thoại đã đăng ký cửa hàng, mời đăng nhập"
////            } else {
////                let vc = CreateInfoVC()
////                vc.bindData(item: store)
////                self.pushVC(controller: vc)
////            }
////        }
//    }
}
