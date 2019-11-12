//
//  WriteQRCodeViewController.swift
//  MyProject
//
//  Created by Ben on 2019/11/5.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import AVFoundation

class WriteQRCodeViewController: UIViewController{
    @IBOutlet weak var myTextFeild: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
    
    var qrcodeImage: CIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func printQRCode(_ sender: Any?){
        if qrcodeImage == nil{
            if myTextFeild.text == ""{
                return
            }
        }
            
        let data = myTextFeild.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter?.outputImage
        
        myImageView.image = UIImage(ciImage: qrcodeImage!)
        
        myTextFeild.resignFirstResponder()
    }
}
