//
//  WebViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/16.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate{
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myWKWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myWKWebView.uiDelegate = self
        self.myWKWebView.navigationDelegate = self
        
        let myURL = URL(string:"https://www.google.com")
        let myRequest = URLRequest(url: myURL!)
        myWKWebView.load(myRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnBackAction(_ sender: Any){
        self.myWKWebView.goBack()
    }
    
    @IBAction func btnGoAction(_ sender: Any){
        let inputStr = myTextField.text!
        print(inputStr)
        let request = URLRequest.init(url: URL.init(string: inputStr)!)
        print(1111)
        self.myWKWebView.load(request)
        print(2222)
    }
}
