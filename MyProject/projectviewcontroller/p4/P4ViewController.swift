//
//  P4ViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/25.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class P4ViewController: VideoSplashViewController{
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
        
        loginButton.layer.cornerRadius = 4
        signupButton.layer.cornerRadius = 4
        
        jsonParser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginButton.center.x -= view.bounds.width
        signupButton.center.x -= view.bounds.width
        
        playAnime()
    }
    
    @IBAction func signBtn(_ sender: UIButton){
        let url = URL(string: "https://youtube.com.tw")!
        UIApplication.shared.open(url)
    }
    
    func playAnime(){
        UIView.animate(withDuration: 0.5, delay: 0.00, options: .curveEaseOut, animations: {
            
            self.loginButton.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.10, options: .curveEaseOut, animations: {
            
            self.signupButton.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupVideoBackground() {
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
        // view.isUserInteractionEnabled = false
        
        // 測試push
        
    }
    
    func jsonParser(){
        let jsonData = "{\"aaa\":\"123\",\"bbb\",\"321\"}"
        print(jsonData)
        
        let personInfo = [PersonInfo(name: "Simon", character: "133"), PersonInfo(name: "P", character: "333")]
        let person = Person(title: "TTT", release_date: "DDD", director: "ddd", cast: personInfo)
        
        let encoder = JSONEncoder()
        let data = try! encoder.encode(person)
        let encodedString = String(data: data, encoding: .utf8)!
        print(encodedString)
    }
    

}

struct Person: Codable{
    var title: String?
    var release_date: String?
    var director: String?
    var cast: [PersonInfo]?
    
}

struct PersonInfo: Codable{
    var name: String?
    var character: String?
}
