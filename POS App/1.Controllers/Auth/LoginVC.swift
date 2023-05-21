//
//  LoginVC.swift
//  POS App
//
//  Created by namnl on 07/05/2023.
//

import UIKit
import LocalAuthentication
import ObjectMapper

class LoginVC: BaseVC {
    var storeData = PStore()
    @IBOutlet var btnShowPassword: UIButton!
    var isShowPassword: Bool = false
    @IBOutlet var btnDangNhap: UIButton!
    
    @IBOutlet var authBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var messageLbl: UILabel!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func bindData(item:PStore){
        storeData = item
        phoneTF.text = item.phone
        passwordTF.text = item.password
    }
    @IBAction func backPressed(_ sender: UIButton) {
        self.onBackNav()
    }
    func setupUI(){
        btnDangNhap.layer.cornerRadius = myCornerRadius.corner10
        messageLbl.text = ""
        if CacheManager.share.isRegister(){
            backBtn.isHidden = true
        }
        authBtn.setImage(UIImage(named: BiometricManager.getImagetBiometric()), for: .normal)
    }
    @IBAction func loginOwnerPressed(_ sender: UIButton) {
        view.endEditing(true)
        guard let phone = phoneTF.text else {return}
        guard let password = passwordTF.text else {return}
        let pStore = PStore(phone: phone, password: password)
        self.showLoading()
        let paramRequest = Utility.getParamFromDirectory(item: pStore.toJSON())
        ServiceManager.common.getStoreMain(param: paramRequest){
            (response) in
            self.hideLoading()
            if response != nil {
                CacheManager.share.setRegister(true)
                CacheManager.share.setUserMaster(value: pStore.toJSONString())
                self.wrapRoot(vc: TabBarVC())
            } else {
                self.messageLbl.text = "Thông báo: số điện thoại hoặc mật khẩu không đúng!"
            }
        }
        //        self.pushVC(controller: TabBarVC())
    }
    @IBAction func hideOrShowPassword(_ sender: UIButton) {
        isShowPassword = !isShowPassword
        if isShowPassword {
            btnShowPassword.setBackgroundImage(UIImage(named: "eys"), for: .normal)
            //code show
        }else{
            btnShowPassword.setBackgroundImage(UIImage(named: "eys.slash"), for: .normal)
        }
    }
    
    @IBAction func dangKyPressed(_ sender: Any) {
        self.pushVC(controller: SignUpVC())
    }
    
    @IBAction func authBiometrics(_ sender: UIButton) {
        print("xac thuc")
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports Face ID or Touch ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate using Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        guard let pStore = Mapper<PStore>().map(JSONString: CacheManager.share.getUserMaster()) else {return}
                        self.phoneTF.text = pStore.phone
                        self.passwordTF.text = pStore.password
                        
                        let paramRequest = Utility.getParamFromDirectory(item: pStore.toJSON())
                        ServiceManager.common.getStoreMain(param: paramRequest){
                            (response) in
                            self.hideLoading()
                            if response != nil {
                                CacheManager.share.setRegister(true)
                                CacheManager.share.setUserMaster(value: pStore.toJSONString())
                                Common.userMaster = pStore
                                self.wrapRoot(vc: TabBarVC())
                            } else {
                                self.messageLbl.text = "Thông báo: số điện thoại hoặc mật khẩu không đúng!"
                            }
                        }
                        print("thanh cong")
                    } else {
                        print("That bai")
                    }
                }
            }
        } else {
            // Biometric authentication not supported
        }
    }
    
}
