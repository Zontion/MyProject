//
//  ProgressViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/17.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProgressViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func show(){
        SVProgressHUD.show()
    }
    
    @IBAction func showWithStatus(){
        SVProgressHUD.show(withStatus: "13232123")
    }
    
    @IBAction func showProgress(){
        SVProgressHUD.showProgress(0.5)
    }
    
    @IBAction func showInfo(){
        SVProgressHUD.showInfo(withStatus: "555555")
    }
    
    @IBAction func showSuccess(){
        SVProgressHUD.showSuccess(withStatus: "SuccessLa")
    }
    
    @IBAction func showError(){
        SVProgressHUD.showError(withStatus: "FailLa")
    }
    
    @IBAction func dismiss(){
        SVProgressHUD.dismiss()
    }
}
