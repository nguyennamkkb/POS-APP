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
        setupData()
    }
    func bindData(item:PStore){
        storeData = item

    }
    func setupData(){
//        phoneTF.text = storeData.phone
//        passwordTF.text = storeData.password
        phoneTF.text = "0358737373"
        passwordTF.text = "123456"
    }
    @IBAction func backPressed(_ sender: UIButton) {
        self.onBackNav()
    }
    func setupUI(){
        passwordTF.isSecureTextEntry = true
        btnDangNhap.layer.cornerRadius = myCornerRadius.corner10
        messageLbl.text = ""
        if CacheManager.share.isRegister(){
            backBtn.isHidden = true
        }
        authBtn.setImage(UIImage(named: BiometricManager.getImagetBiometric()), for: .normal)
        
        
        phoneTF.text = "0358737373"
        passwordTF.text = "123456"
    }
    @IBAction func loginOwnerPressed(_ sender: UIButton) {
        view.endEditing(true)
        guard let phone = phoneTF.text else {return}
        guard let password = passwordTF.text else {return}
        self.showLoading()
        login(phone: phone, password: password)
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
//        print("xac thuc")
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
                        self.login(phone: pStore.phone ?? "", password: pStore.password ?? "")
//                        print("thanh cong")
                    } else {
//                        print("That bai")
                    }
                }
            }
        } else {
            // Biometric authentication not supported
        }
    }
    func login(phone: String, password: String){
        let paramRequest = LoginParam(phone: phone, password: password)
        ServiceManager.common.signIn(param: paramRequest){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                CacheManager.share.setRegister(true)
                let data = Mapper<PStore>().map(JSONObject: response?.data)
                data?.password = paramRequest.password
                CacheManager.share.setUserMaster(value: data?.toJSONString())
                Common.userMaster = data ?? PStore()
                self.wrapRoot(vc: TabBarVC())
            } else if response?.statusCode == 0 {
                self.messageLbl.text = "Thông báo: \(response?.message ?? "" )"
            }
        }
    }
}
