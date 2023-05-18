//
//  SignUpVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit
import ObjectMapper
class SignUpVC: BaseVC {
    
    @IBOutlet var btnShowPassword: UIButton!
    @IBOutlet var xacNhanBtn: UIButton!
    @IBOutlet var noteView: UIView!
    @IBOutlet var messageLbl: UILabel!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    var isShowPassword: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkData()
    }
    func setupUI(){
        noteView.layer.cornerRadius = myCornerRadius.corner10
        xacNhanBtn.layer.cornerRadius = myCornerRadius.corner10
        messageLbl.text = ""
    }
    
    @IBAction func xacNhanPressed(_ sender: UIButton) {
        view.endEditing(true)
        guard let phone = phoneTF.text else {return}
        guard let password =  passwordTF.text, password.count >= 6 else {return}
        self.showLoading()
        let store = PStore()
        store.phone = phone
        let paramRequest = Utility.getParamFromDirectory(item: store.toJSON())
        ServiceManager.common.getStoreMain(param: paramRequest){
            (response) in
            self.hideLoading()
            if response != nil {
                self.messageLbl.text = "Thông báo: Số điện thoại đã đăng ký cửa hàng, mời đăng nhập"
            } else {
                store.password = password
                let vc = CreateInfoVC()
                vc.bindData(item: store)
                self.pushVC(controller: vc)
            }
        }
       
        
    }
    
    @IBAction func hideOrShowPassword(_ sender: UIButton) {
        isShowPassword = !isShowPassword
        if isShowPassword {
            btnShowPassword.setImage(UIImage(systemName: "eye"), for: .normal)
            //code show
        }else{
            
            btnShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            //code hide
        }
    }
    
    @IBAction func dangNhapPressed(_ sender: Any) {
        self.pushVC(controller: LoginVC())
    }
    
    func checkData(){
//        let store = PStore()
//        store.phone = "0358737373"
//
//        let paramRequest = Utility.getParamFromDirectory(item: store.toJSON())
//        ServiceManager.common.getStoreMain(param: paramRequest){
//            (response) in
//
//           
//            if response != nil {
//    
//                self.messageLbl.text = "Thông báo: Số điện thoại đã đăng ký cửa hàng, mời đăng nhập"
//            } else {
//                let vc = CreateInfoVC()
//                vc.bindData(item: store)
//                self.pushVC(controller: vc)
//            }
//        }
    }
}
