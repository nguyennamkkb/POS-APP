//
//  ThongBaoVC.swift
//  LN POS
//
//  Created by Mac mini on 25/04/2024.
//

import UIKit

class ThongBaoVC: UIViewController {

    @IBOutlet weak var lbLoiNhan: UILabel!
    @IBOutlet weak var imgTrangThai: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vDong: UIView!
    @IBOutlet weak var vThongBao: UIView!
    var trangThaiDong: Int = 0
    var nTitle: String = "Thành công"
    var nLoiNhan: String = ""
    var trangThaiLoiNhan: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        vThongBao.layer.cornerRadius = myCornerRadius.corner20
        vDong.layer.cornerRadius = myCornerRadius.corner10
        vDong.addBorder(color: myColor.SPA_FE!, width: 1)
        
        
        
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {


        DispatchQueue.main.async { // Sử dụng DispatchQueue.main.async
            
            if (self.trangThaiLoiNhan == 1){
                self.lbTitle.text = "Thành công"
                self.imgTrangThai.image = UIImage(named: "ic_thanhcong")!
            }else if (self.trangThaiLoiNhan == 0){
                self.lbTitle.text = "Thất bại"
                self.imgTrangThai.image = UIImage(named: "ic_thatbai")!
            }
            self.lbLoiNhan.text = self.nLoiNhan // Cập nhật UI trong block async
       }
    }
    func setupUI(){
        
        lbLoiNhan.text = nLoiNhan
        lbTitle.text = nTitle
        if (trangThaiLoiNhan == 1){
            imgTrangThai.image = UIImage(named: "ic_thanhcong")!
        }else if (trangThaiLoiNhan == 0){
            imgTrangThai.image = UIImage(named: "ic_thatbai")!
        }
    
    }
    
    @IBAction func btnDongPressed(_ sender: Any) {
        dong()
    }
    func dong(){
        dismiss(animated: false)
    }
    func bindData(trangThai: Int, loiNhan: String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dong()
        }
        trangThaiLoiNhan = trangThai
        nLoiNhan = loiNhan
        
        
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
