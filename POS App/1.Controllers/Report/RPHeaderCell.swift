//
//  RPHeaderCell.swift
//  POS App
//
//  Created by namnl on 25/07/2023.
//

import UIKit
import MobileCoreServices
import DropDown
import AVFoundation

class RPHeaderCell: UITableViewCell {

    @IBOutlet weak var timeFromDPicker: UIDatePicker!
    @IBOutlet weak var timeToDPicker: UIDatePicker!
    var fromSelect: ClosureCustom<Int64>?
    var toSelect: ClosureCustom<Int64>?
    let dateFormater = DateFormatter()
    
    @IBOutlet var countLbl: UILabel!
    @IBOutlet var moneyLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(money: Int, count: Int, timeFrom: Int64, timeTo: Int64){
        moneyLbl.text = "\(String(money).currencyFormatting())đ"
        countLbl.text = "\(count)"
    
//        print(timeFrom)
//        print(timeTo)
        timeFromDPicker.date = Common.dateFromUnixTimestamp(milliseconds: Double(timeFrom))
        timeToDPicker.date = Common.dateFromUnixTimestamp(milliseconds: Double(timeTo))

    }
    @IBAction func timeFromChanged(_ sender: UIDatePicker) {
        let time = sender.date.millisecondsSince1970
        let timeString = Common.convertTimestampToDate(timestampString: String(time), dateFormat: "dd-MM-yyyy 00:00:00")
        if let timeFromMilis = Common.dateStringToMilis(dateString:timeString) {
//            print(timeFromMilis)
            fromSelect?(timeFromMilis)
        }
        
    }
    @IBAction func timeToChanged(_ sender: UIDatePicker) {
        let time = sender.date.millisecondsSince1970
        let timeString = Common.convertTimestampToDate(timestampString: String(time), dateFormat: "dd-MM-yyyy 00:00:00")
        if var timeToMilis = Common.dateStringToMilis(dateString:timeString) {
            timeToMilis = timeToMilis + 86400000 - 1
//            print(timeToMilis)
            toSelect?(timeToMilis)
        }
    }
    
}
