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
    @IBOutlet weak var vForm: UIView!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vPass: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        // Do any additional setup after loading the view.
//        setupData()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img_bg")!)
    }
    func bindData(item:PStore){
        storeData = item
    }
    func setupData(){
        tfEmail.text = "nguyennam.kkb@gmail.com"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img_bg")!)
    }

    func setupUI(){
        tfPassword.isSecureTextEntry = true
        btnDangNhap.layer.cornerRadius = myCornerRadius.corner10

        authBtn.setImage(UIImage(named: BiometricManager.getImagetBiometric()), for: .normal)
    
        vForm.layer.cornerRadius = myCornerRadius.corner20
        vEmail.layer.cornerRadius = myCornerRadius.corner10
        vPass.layer.cornerRadius = myCornerRadius.corner10

        vEmail.addBorder(color: myColor.SPA_FE!, width: 1)
        vPass.addBorder(color: myColor.SPA_FE!, width: 1)

        
    }
    @IBAction func quenMatKhauPressed(_ sender: Any) {
        let vc = ForgetPasswordVC()
        self.pushVC(controller: vc)
        
    }
    @IBAction func btnDangNhapPressed(_ sender: Any) {
        //        let vc = TabBarVC()
        ////        self.pushVC(controller: vc)
        //        self.wrapRoot(vc: vc)
//        guard let email = tfEmail.text, InputCommon.isValidEmail(email: email) else {
        guard let email = tfEmail.text, email.count >= 6  else {
            print("email")
            self.hienThiLoiNhan(s: "Kiểm tra lại email")
            return}
        guard let password = tfPassword.text, password.count >= 6 else {
            print("pass")
            self.hienThiLoiNhan(s: "Kiểm tra lại mật khẩu")
            return}
        
        login(email: email, password: password)
   
        
        
    }
    
    
    
    
    
    
//    
//    @IBAction func loginOwnerPressed(_ sender: UIButton) {
//        view.endEditing(true)
//        guard let email = tfEmail.text else {return}
//        guard let password = tfPassword.text else {return}
//        self.showLoading()
//        login(phone: email, password: password)
//    }
//    @IBAction func hideOrShowPassword(_ sender: UIButton) {
//        isShowPassword = !isShowPassword
//        if isShowPassword {
//            btnShowPassword.setBackgroundImage(UIImage(named: "eys"), for: .normal)
//            //code show
//        }else{
//            btnShowPassword.setBackgroundImage(UIImage(named: "eys.slash"), for: .normal)
//        }
//    }
//    
    @IBAction func dangKyPressed(_ sender: Any) {
        self.pushVC(controller: SignUpVC())
    }
//    
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
                        
                        guard let emailData = NKeyChain.share.loadDataFromKeychain(forKey: NKeyChain.share.kLogin),let emailString = String(data: emailData, encoding: .utf8) else {
                            print("Loi email")
                            return}
                        print("NKeyChain. luuMatKhau \(emailString)")
                        guard let password = NKeyChain.share.loadDataFromKeychain(forKey: "\(emailString)"),let passString = String(data: password, encoding: .utf8) else {
                            print("Loi pass")
                            return}
                        
                        print("lay keychain")
                        print(emailString)
                        print(passString)
                        self.tfEmail.text = "\(emailString)"
                        self.tfPassword.text = "\(passString)"
                        self.showLoading()
                        self.login(email: pStore.email ?? "", password: pStore.password ?? "")
                       
                    } else {
//                        print("That bai")
                    }
                }
            }
        } else {
            // Biometric authentication not supported
        }
    }
    func login(email: String, password: String){
        let paramRequest = LoginParam(email: email, password: password)
        paramRequest.sign()
        ServiceManager.common.signIn(param: paramRequest){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                print("200")
                CacheManager.share.setRegister(true)
                
                let data = Mapper<PStore>().map(JSONObject: response?.data)
                data?.password = paramRequest.password
                CacheManager.share.setUserMaster(value: data?.toJSONString())
                
                Common.userMaster = data ?? PStore()

                let luuMatKhau = NKeyChain.share.saveDataToKeychain(data: password.data(using: .utf8)!,forKey: email)
                let luuEmail = NKeyChain.share.saveDataToKeychain(data: email.data(using: .utf8)!,forKey: NKeyChain.share.kLogin)
                if luuMatKhau, luuEmail {
                    print("Password saved successfully!")
                } else {
                    print("Failed to save password.")
                }
                
                
                self.wrapRoot(vc: TabBarVC())
//                print("200",response ?? "")
                
            }
            
            else if response?.statusCode == 199 || response?.statusCode == 2 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "Đã gửi OTP kích hoạt vào email: \(email)")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1  ) {
                    let vc = XacThucTaiKhoanVC()
                    vc.bindData(email: email)
                    self.pushVC(controller: vc)
                }
            }
            else {
                print("response?.statusCode", response?.statusCode ?? 0)
               self.hienThiThongBao(trangThai: 0, loiNhan: "Có vẻ Email hoặc Mật khẩu không đúng!")
           }
        }
    }
}
