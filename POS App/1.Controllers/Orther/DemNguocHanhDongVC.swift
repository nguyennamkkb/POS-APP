//
//  DemNguocHanhDongVC.swift
//  LN POS
//
//  Created by Mac mini on 03/05/2024.
//

import UIKit

class DemNguocHanhDongVC: BaseVC {
    @IBOutlet weak var pvTienTrinh: UIProgressView!
    
    private var timer: Timer?
    
    @IBOutlet weak var lbTieuDe: UILabel!
    var thoiGianDemNguoc: Int = 5
    var thoiGianDangChay: Bool = false
    var actOK: ClosureAction?
    var actHuy: ClosureAction?
    var daAnNut: Int = 0
    @IBOutlet weak var lbThoiGian: UILabel!
    
    @IBOutlet weak var vChinh: UIView!
    
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var btnHuy: UIButton!
    
    var tieuDe: String = "Xác nhận thao tác"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        startCountdown()
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        btnHuy.layer.cornerRadius = myCornerRadius.corner10
        vChinh.layer.cornerRadius = myCornerRadius.corner10
        pvTienTrinh.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        lbTieuDe.text =  tieuDe
    }
    private func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.updateTimerAndLabel()
        }
    }
    func bindData(s: String = "Xác nhận thao tác"){
        tieuDe = s
    }
    private func updateTimerAndLabel() {
        if thoiGianDemNguoc > 0 {
            lbThoiGian.text = String(thoiGianDemNguoc)
            pvTienTrinh.progress = Float(thoiGianDemNguoc) / Float(5)
            thoiGianDemNguoc -= 1
            
        } else {
            timer?.invalidate()
            lbThoiGian.text = "0"
            if daAnNut == 0 {
                actOK?()
                dismissVC()
            }
        }
    }
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        daAnNut = 1
        self.actOK?()
        dismissVC()
    }
    @IBAction func btnHuyPressed(_ sender: Any) {
        daAnNut = 1
        dismissVC()
    }
    
    
}
