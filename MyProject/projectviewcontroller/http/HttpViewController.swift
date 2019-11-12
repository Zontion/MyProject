//
//  HttpViewController.swift
//  MyProject
//
//  Created by Ben on 2019/11/11.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class HttpViewController: UIViewController{
    
    @IBOutlet weak var btnGet: UIButton!
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var lbText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyWithEportal()
    }
    
    func verifyWithEportal() {
        
        let parameters = [
            "appName": "zontion",
            "password": "1244",
            "userUID": "12766",
            "uuid": "97522"
        ]
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        APIService.shared.postData(data: parameters, urlString:url, completionHandler: { [unowned self] (result) in
            print("1111111\(result)")
            
            DispatchQueue.main.async {
                switch result {
                case .success(let object):
                    print("2222222\(object.self)")
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        })
    }
}
