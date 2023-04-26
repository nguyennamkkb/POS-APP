//
//  ExTextField.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit
extension UITextField {
    
    func setBottomBorder() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: self.frame.height))
        self.leftViewMode = .always
        
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func csa() {
        let border = CALayer()
            let borderWidth = CGFloat(1.0) // Border Width
            border.borderColor = UIColor.lightGray.cgColor
            border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
            border.borderWidth = borderWidth
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
    }
}
