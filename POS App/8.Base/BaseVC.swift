//
//  BaseVC.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit
class BaseVC: UIViewController {
    
    
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
    func pushVC(controller vc: UIViewController, hidesBottomBarWhenPushed hidesBottomBar: Bool = false, animation anima: Bool = true) {
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
}
extension BaseVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            return true
        }
        return false
    }
}

