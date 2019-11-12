//
//  P1ViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/21.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class P1ViewController: UIViewController{
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var runBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    var counter: Float = 0.0{
        didSet{
            myLabel.text = String(format: "%.1f", counter)
        }
    }
    
    var timer: Timer? = Timer()
    var isPlaying = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 0.0
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIButton) {
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
        counter = 0
        runBtn.isEnabled = true
        stopBtn.isEnabled = true
    }
    
    @IBAction func runButtonDidTouch(_ sender: UIButton) {
        runBtn.isEnabled = false
        stopBtn.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func stopButtonDidTouch(_ sender: UIButton) {
        runBtn.isEnabled = true
        stopBtn.isEnabled = false
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
        
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
    }
}
