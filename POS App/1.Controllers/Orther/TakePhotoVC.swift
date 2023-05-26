//
//  TakePhotoVC.swift
//  POS App
//
//  Created by namnl on 21/05/2023.
//

import UIKit
import AVFoundation
class TakePhotoVC: UIViewController {
    var getBase64Image: ClosureCustom<String>?
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setupCamera() {
        captureSession = AVCaptureSession()
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            // Handle case where back camera is not available
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            captureSession?.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.isHighResolutionCaptureEnabled = true
            
            if let photoOutput = photoOutput, captureSession?.canAddOutput(photoOutput) == true {
                captureSession?.addOutput(photoOutput)
            }
        } catch {
            // Handle error
        }
    }
    func capturePhoto() {
        guard let photoOutput = photoOutput else {
            // Handle case where photo output is not available
            return
        }
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
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
extension TakePhotoVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let image = UIImage(data: imageData)
            let base64String = imageData.base64EncodedString()
            captureSession?.stopRunning()

        }
    }
}
