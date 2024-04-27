//
//  XacNhanVC.swift
//  LN POS
//
//  Created by Mac mini on 26/04/2024.
//

import UIKit

class XacNhanVC: UIViewController {

    @IBOutlet weak var lbLoiNhan: UILabel!
    var loiNhan: String = ""
    var actDongY: ClosureAction?
    var actKhong: ClosureAction?
    @IBOutlet weak var btnDongY: UIButton!
    @IBOutlet weak var btnKhong: UIButton!
    @IBOutlet weak var vXacNhan: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        vXacNhan.layer.cornerRadius = myCornerRadius.corner10
        btnDongY.layer.cornerRadius = myCornerRadius.corner10
        btnKhong.layer.cornerRadius = myCornerRadius.corner10
        vXacNhan.layer.cornerRadius = myCornerRadius.corner10
//        self.modalPresentationStyle = .overCurrentContext
//        self.modalTransitionStyle = .crossDissolve
        lbLoiNhan.text = loiNhan
        vXacNhan.addShadow()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let distanceToMove: CGFloat = 50
        
        // Di chuyển UIView xuống dưới 50 pixel
        let newFrame = CGRect(x: vXacNhan.frame.origin.x, y: vXacNhan.frame.origin.y + distanceToMove, width: vXacNhan.frame.size.width, height: vXacNhan.frame.size.height)
        
        // Đặt vị trí ban đầu của UIView lên ngoài màn hình
        vXacNhan.frame = CGRect(x: vXacNhan.frame.origin.x, y: vXacNhan.frame.origin.y - distanceToMove, width: vXacNhan.frame.size.width, height: vXacNhan.frame.size.height)
        
        // Đặt alpha ban đầu của UIView thành 0 (ẩn)
        vXacNhan.alpha = 0
        
        // Thực hiện animation để di chuyển UIView xuống và hiện
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.vXacNhan.frame = newFrame
            self.vXacNhan.alpha = 1 // Đặt alpha của UIView thành 1 (hiển thị)
        }, completion: nil)
    }

    func bindData(s: String){
        loiNhan = s
    }
    @IBAction func btnKhongPressed(_ sender: Any) {
        actKhong?()
        
        dismiss(animated: false)
    }
    @IBAction func btnDongYPressed(_ sender: Any) {
        
        actDongY?()
        dismiss(animated: false)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
