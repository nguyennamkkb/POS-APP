//
//  ContactVC.swift
//  LN POS
//
//  Created by namnl on 06/08/2023.
//

import UIKit

class ContactVC: BaseVC {

    @IBOutlet weak var detailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        detailLbl.text = """
Ứng dụng dành cho tiệm tóc, Spa, làm móng ...
Có khoảng 10 nhân viên
Giúp
Tạo và theo dõi lịch làm việc
Thống kê doanh thu theo ngày hoặc tháng
của cửa hàng và mỗi nhân viên
Tính giá của mỗi lần làm dịch vụ của khách.
"""
    }

    @IBAction func goHomePressed(_ sender: Any) {
        self.wrapRoot(vc: TabBarVC())
    }
    

}
