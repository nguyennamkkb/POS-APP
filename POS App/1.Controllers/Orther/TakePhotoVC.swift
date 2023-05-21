//
//  TakePhotoVC.swift
//  POS App
//
//  Created by namnl on 21/05/2023.
//

import UIKit

class TakePhotoVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var getBase64Image: ClosureCustom<String>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func takePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Delegate method to handle when the image is captured
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            convertImageToBase64(image: image, compressionQuality: 0.3) { base64String in
                guard let base64String = base64String else {return}
                Common.anhChupAvatar = base64String
                self.getBase64Image?(base64String)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Delegate method to handle when the image capture is canceled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Function to convert the image to base64
    func convertImageToBase64(image: UIImage, compressionQuality: CGFloat, completion: @escaping (String?) -> Void) {
        DispatchQueue.global().async {
            if let imageData = image.jpegData(compressionQuality: compressionQuality) {
                let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
                completion(base64String)
            } else {
                completion(nil)
            }
        }
    }
    
    
}
