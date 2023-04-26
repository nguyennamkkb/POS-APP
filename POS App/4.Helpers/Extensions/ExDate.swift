//
//  ExDate.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
//MARK: Biến, hằng số
let TimeFormat: String = "HH:mm"
let DateTimeFormat: String = "dd/MM/yyyy HH:mm"
let SplashDate: String = "dd/MM/yyyy"
let kMinDateString = "01/01/1753 12:00:00 AM"
let kMaxDateString = "01/01/9999 12:00:00 AM"


// MARK: Các format thời gian.
let kDateFormatUTC = "yyyy-MM-dd'T'HH:mm:ss'Z'"             //Format date lưu trong DB
let kDateFormatLocalDB = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ"             //Format date lưu trong DB
let kDateFormatSync    = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ" //Format theo timzone, có milisecond(phổ biến)

let kDateFormatServer  = "yyyy-MM-dd'T'HH:mm:ssZZ"     //Format timzone ko có milisecond
let kDateFormatServer2 = "yyyy-MM-dd'T'HH:mm:ss.SSS"   //Format theo timzone không có milisecond
let kDateFormatServer3 = "yyyy-MM-dd'T'HH:mm:ss"       //Format ko timezone,ko milisecond
let kDateFormatServer4 = "yyyy-MM-dd"                  //Format ngay thang,ko timezone.
let kDateFormatServer5 = "yyyy-MM-ddZZZZZ"             //Format ngay thang co timezone.
let kDateFormatServer6 = "yyyy-MM-dd'T'HH:mmZZ"
let kDateFormatServer7 = "dd MMMM, yyyy"
let kDateFormatServer8 = "yyyy-MM-dd'T'HH:mm:ss.SSSZZ"
let kDateFormatServer9 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

let kDateFormatDDMMYYYYHHMM = "dd/MM/yyyy HH:mm"
let kDateFormatMMDDYYYYHHMM = "MM/dd/yyyy HH:mm"
let kDateFormatYYYYMMDDHHMM = "yyyy/MM/dd HH:mm"
let kDateFormatHHMmDDMMMYYYY = "HH:mm dd MMM, yyyy"
let kDateFormatDD_MMM_YYYY = "dd MMM yyyy"

let kDateFormatDDMMYYYY = "dd/MM/yyyy"
let kDateFormatMMDDYYYY = "MM/dd/yyyy"
let kDateFormatYYYYMMDD = "yyyy/MM/dd"
let kDateFormatDDMM = "dd/MM"
let kDateFormatDDMMHHMM = "dd/MM HH:mm"
let kDateFormatDDMMM = "dd MMM"
let kDateFormatMMDD = "MM/dd"
let kDateFormatDD = "dd"
let kDateFormatMMMM = "MMMM"
let kDateFormatMMMMYYYY = "MMMM, yyyy"
let kDateFormathhmm = "HH:mm"

let kDateFormatmmYYYY = "MM/yyyy"
let kDateFormatYYYYMM = "yyyy/MM"

let kDateFormatDDMMYYYYHHMMA = "dd/MM/yyyy hh:mm a"
let kDateFormatHHMMA = "hh:mm a"
let kDateFormatISO = "MM/dd/yyyy hh:mm:ss a"
let amSymbol = "SA"
let pmSymbol = "CH"
let kDateFormatSQL = "yyyy-MM-dd"
let kDateTimeFormatSQL = "yyyy-MM-dd HH:mm:ss"

let kDateFormatDDMMYYYYHHMMSS = "dd/MM/yyyy HH:mm:ss"
let kDateFormatMMDDYYYYHHMMSS = "MM/dd/yyyy HH:mm:ss"
let kDateFormatYYYYMMDDHHMMSS = "yyyy/MM/dd HH:mm:ss"
let kDateFormatYYYY = "yyyy"

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func toString(format: String) -> String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
    
//    func getCurrentDateTime() -> String {
//        let temp = "ex_date_d_".localizableString()
//        return String(format: temp, self.getWeekDayString(), self.day, self.month, self.year)
//    }
//
//    func getWeekDayString() -> String {
//        switch Calendar.current.component(.weekday, from: self) {
//        case 1:
//            return "the_sun".localizableString()
//        case 2:
//            return "the_mon".localizableString()
//        case 3:
//            return "the_tue".localizableString()
//        case 4:
//            return "the_wed".localizableString()
//        case 5:
//            return "the_thur".localizableString()
//        case 6:
//            return "the_fri".localizableString()
//        case 7:
//            return "the_satur".localizableString()
//        default:
//            return ""
//        }
//    }
}

extension String {
    
    func toDate(format: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.locale = Locale(identifier: "vi_VN")
        return dateFormat.date(from: self)
    }
}


extension Date {
    //MARK: week
    func dateByAddingDays(_ days: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.day = days
        return Calendar.init(identifier: .gregorian).date(byAdding: dateComp, to: self)!
    }
    
    static func getDayToStartWeek(dayInWeek: Int) -> Int {
        var dayToStartWeek: Int = 0
        switch dayInWeek {
        case 1:
            // chu nhat
            dayToStartWeek = 6
        case 2:
            dayToStartWeek = 0
        case 3:
            dayToStartWeek = 1
        case 4:
            dayToStartWeek = 2
        case 5:
            dayToStartWeek = 3
        case 6:
            dayToStartWeek = 4
        case 7:
            dayToStartWeek = 5
        default:
            break
        }
        return dayToStartWeek
    }
    
    
    
   
   
    
    //MARK: year
    static func getFirstDateOfMonth(month: Int, year: Int) -> Date? {
        var component = DateComponents()
        component.day = 1
        component.month = month
        component.year = year
        let calendar = Calendar.init(identifier: .gregorian)
        let tempStartMonth = calendar.date(from: component)
        return tempStartMonth
    }
    
  
    
    static func getFirstDateOfQuater(quater: Int, year: Int) -> Date? {
        var component = DateComponents()
        component.day = 1
        if quater == 1 {
            component.month = 1
        } else if quater == 2 {
            component.month = 4
        } else if quater == 3 {
            component.month = 7
        } else {
            component.month = 10
        }
        component.year = year
        let calendar = Calendar.init(identifier: .gregorian)
        let tempStartQuater = calendar.date(from: component)
        return tempStartQuater
    }
    
   
    
    
    
    static func getFirstDateOfYear(year: Int) -> Date? {
        let tempStartYear = getFirstDateOfMonth(month: 1, year: year)
        return tempStartYear
    }
    
    
    static func getLastDateOfYear(year: Int) -> Date? {
        let firstYear = Date.getFirstDateOfYear(year: year)
        let firstNextYear = firstYear?.dateByAddingYears(1)
        return firstNextYear?.dateByAddingDays(-1)
    }
    
    func dateByAddingYears(_ years: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.year = years
        return Calendar.init(identifier: .gregorian).date(byAdding: dateComp, to: self)!
    }
}


class QuarterObject: NSObject {
    var startQuarter: Date!
    var endQuarter: Date!
    var index: Int!
}

