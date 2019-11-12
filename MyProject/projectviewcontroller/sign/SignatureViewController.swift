//
//  SignatureViewController.swift
//  MyProject
//
//  Created by Ben on 2019/11/11.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController{
    
    @IBOutlet weak var signView: SignView!
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnEnsure: UIButton!
    @IBOutlet weak var ivShowArea: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSignViewStyle()
    }
    
    func setSignViewStyle(){
        signView.layer.borderWidth = 3
        signView.layer.borderColor = UIColor.red.cgColor
        signView.layer.cornerRadius = 6
        
        signView.clipsToBounds = true
        signView.isMultipleTouchEnabled = false
    }
    
    func viewToImage(view: UIView) -> UIImage{
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
    
    @IBAction func clearDraw(_ sender: UIButton){
        signView.clearCanvas()
    }
    
    @IBAction func ensureBtn(_ sender: UIButton){
        ivShowArea.image = viewToImage(view: signView)
    }
}
