//
//  BaseVC.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit
import FittedSheets
class BaseVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let alertView = UIView()
    var messageLabel = UILabel()
    let activityScreen = LoadingVC()
    var isHiddenNav: Bool = false
    var isLarge: Bool = false
    var isShadow: Bool = true
    var animation: Bool = true
    var statusBarType: UIStatusBarStyle = UIStatusBarStyle.default{
        didSet{
            setNeedsStatusBarAppearanceUpdate()
            self.navigationController?.navigationBar.barStyle = .default
        }
    }

    var getBase64Image: ClosureCustom<String>?
    func setLayoutAlert(){
        alertView.layer.zPosition = 999
        view.addSubview(alertView)
        alertView.backgroundColor = UIColor(hex: "#0A0A0A")
        alertView.frame = CGRect(x: 40, y: -50, width: self.view.frame.width - 80, height: 44)
        alertView.layer.cornerRadius = 15
        messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 44))
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = .white
        alertView.addSubview(messageLabel)
        alertView.layer.shadowColor = UIColor.gray.cgColor
        alertView.layer.shadowOpacity = 0.2
        alertView.layer.shadowOffset = .zero
        alertView.layer.shadowRadius = 10
        alertView.layer.borderColor = UIColor.gray.cgColor
        alertView.layer.borderWidth = 1
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
#if DEBUG
        print("ScreenName: \(String(describing: type(of: self)))")
#endif
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        addBackButton()
        statusBarType = .lightContent
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationItem.setHidesBackButton(true, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        activityScreen.modalPresentationStyle = .overCurrentContext
        activityScreen.modalTransitionStyle = .crossDissolve
        setLayoutAlert()
    }
    func showAlert(message: String?){
        self.messageLabel.text  = message ?? ""
        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(x: 40, y: 50, width: self.view.frame.width - 80, height: 44)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.hideAlert()
        }
    }
    func hideAlert(){
        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(x: 40, y: -50, width: self.view.frame.width - 80, height: 44)
        }
    }
    func showMessageDeveloping(){
        showAlert(message: "Chức năng đang phát triển")
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func dismissVC(animated: Bool = true) {
        let vc = self.navigationController?.popViewController(animated: animated)
        
        if vc == nil {
            dismiss(animated: animated, completion: nil)
        }
    }
    func pushVC(controller vc: UIViewController, hidesBottomBarWhenPushed hidesBottomBar: Bool = false, animation anima: Bool = false) {
        vc.hidesBottomBarWhenPushed = hidesBottomBar
        self.navigationController?.pushViewController(vc, animated: anima)
    }
    //    func addBackButton() {
    //        let barItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_back"), style: .plain, target: self, action: #selector(onBackNav))
    //        self.navigationItem.leftBarButtonItem.bac
    //        self.navigationItem.leftBarButtonItem = barItem
    //    }
    
    
    func onBackNav() {
        let vc = self.navigationController?.popViewController(animated: animation)
        if vc == nil{
            dismiss(animated: animation, completion: nil)
        }
    }
    func wrapRoot(vc: UIViewController){
        guard let window = self.view.window else {return}
        window.switchRootViewController(vc)
    }
    func showLoading(){
        present(activityScreen, animated: false, completion: nil)
    }
    func hideLoading(){
        activityScreen.closeActivity()
    }
  
    
}
extension BaseVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            return true
        }
        return false
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var base64String : String = ""
        if let image = info[.originalImage] as? UIImage {
            base64String = image.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
            // Use the base64String as needed
            Common.anhChupAvatar = base64String
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
