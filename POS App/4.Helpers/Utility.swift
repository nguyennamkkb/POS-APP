//
//  Utility.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit
import ObjectMapper
import Kingfisher

public class Utility {

    public static func cropImg(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    public static func clearCacheKingfisher() {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    static func runOnBackgroundThread(execute: @escaping () -> Swift.Void) {
        DispatchQueue.global(qos: .background).async {
            execute()
        }
    }
    static func runOnMainThread(execute: @escaping () -> Swift.Void) {
        DispatchQueue.main.async {
            execute()
        }
    }
    static func isNilOrEmpty(_ string: String?) -> Bool {
        return (string ?? "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    private static let currencyFormatter = NumberFormatter()
    public static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage //?? UIImage()
    }
    
    //chuyen doi tien tien te
    public static func convertCurrency (money: Double) -> String {
        
        //currencyFormatter.usesGroupingSeparator = true
        //currencyFormatter.numberStyle = .currency
        currencyFormatter.numberStyle = .decimal
        // localize to your grouping and decimal separator
        //currencyFormatter.locale = Locale.current
        currencyFormatter.groupingSeparator = "."
        
        //local VN
        //currencyFormatter.locale = Locale(identifier: "vn_VN")
        //currencyFormatter.locale = Locale(identifier: "fr_FR")
        
        return "\(currencyFormatter.string(from: NSNumber(value: money))!)"
    }
    
    static func currencyChange(money: String) -> String {
        guard money.count > 0 else {
            return ""
        }
        
        let tienSo = Double(money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil))!
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.groupingSeparator = "."
        return "\(currencyFormatter.string(from: NSNumber(value: tienSo))!)"
        //return ""
    }
    
    static func currencyToDoble(money: String) -> Double {
        guard money.count > 0 else {
            return 0
        }
        
        return Double(money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)) as! Double
    }
    
    
}

