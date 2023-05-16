//
//  CreateCalenderVC.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit

class CreateCalenderVC: BaseVC {
    
    @IBOutlet var chonNVView: UIView!
    @IBOutlet var nhanVienLB: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    func setupUI() {
        chonNVView.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnSelectNVPressed(_ sender: Any) {
        print("chon NV")
    }
    @IBAction func btnSelectKHPressed(_ sender: Any) {
        print("chon KH")
    }
    
    @IBAction func BtnSelectDateTime(_ sender: UIButton) {
        print("BtnSelectDateTime")
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        // Do something with the selected date
        print(selectedDate)
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
