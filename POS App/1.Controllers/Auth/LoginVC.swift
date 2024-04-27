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
        tfPassword.text = "123456"
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
                        self.tfEmail.text = pStore.email
                        self.tfPassword.text = pStore.password
                        self.login(email: pStore.email ?? "", password: pStore.password ?? "")
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
                self.wrapRoot(vc: TabBarVC())
//                print("200",response ?? "")
                
            }
            
            else if response?.statusCode == 199 || response?.statusCode == 2 {
                print("response?.statusCode",response?.statusCode)
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
