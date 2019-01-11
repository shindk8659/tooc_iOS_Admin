//
//  QRScanViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/3/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import AVFoundation
protocol sendReservationCode {
    func sendCode(code:String)
}
class QRScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var myQRCodeImageView: UIImageView!
   
    let session = AVCaptureSession()
    var delegate: sendReservationCode?
    var video = AVCaptureVideoPreviewLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.addBackButton("white")
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }catch {
            
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = self.view.frame
        self.view.layer.addSublayer(video)
        session.startRunning()
        self.view.bringSubviewToFront(myQRCodeImageView)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    self.session.stopRunning()
                    self.delegate?.sendCode(code: gsno(object.stringValue))
                    self.tabBarController?.selectedIndex = 1;
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}

