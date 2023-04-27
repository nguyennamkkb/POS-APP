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
    var statusBarType: UIStatusBarStyle = UIStatusBarStyle.lightContent{
        didSet{
            setNeedsStatusBarAppearanceUpdate()
            
            if statusBarType == .lightContent {
                self.navigationController?.navigationBar.barStyle = .black
            } else {
                self.navigationController?.navigationBar.barStyle = .default
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return statusBarType
    }
    override func viewWillAppear(_ animated: Bool) {
        #if DEBUG
        print("ScreenName: \(String(describing: type(of: self)))")
        #endif
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
        
        statusBarType = .lightContent
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
}
extension BaseVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            return true
        }
        return false
    }
}

