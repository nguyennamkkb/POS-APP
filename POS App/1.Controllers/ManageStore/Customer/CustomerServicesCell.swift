//
//  CustomerServicesCell.swift
//  POS App
//
//  Created by namnl on 29/06/2023.
//

import UIKit

class CustomerServicesCell: UITableViewCell {

    
    @IBOutlet weak var vItem: UIView!
    //    @IBOutlet var itemView: UIView!
//    @IBOutlet var amoutLbl: UILabel!
//    @IBOutlet var employeeLbl: UILabel!
//    @IBOutlet var dateLbl: UILabel!
//    var books =  PBookCalender()
    override func awakeFromNib() {
        
        super.awakeFromNib()
        vItem.layer.cornerRadius = myCornerRadius.corner10

    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    func bindData(item: PBookCalender){
//        books = item
//        amoutLbl.text = "\(books.amount ?? 0)".currencyFormatting()
//        employeeLbl.text = "\(books.employee?.fullName ?? "")"
//        dateLbl.text = Common.getDateFormatFromMiliseonds(time: books.updateAt ?? "")
//    }
//    func setupUI(){
//        itemView.layer.cornerRadius = myCornerRadius.corner5
//        itemView.layer.borderWidth = 0.1
//        itemView.layer.shadowOffset = CGSize(width: 1, height:1)
//
//
//    }
}
