//
//  P2ViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/21.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class P2ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var goBtn: UIButton!
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var cheatMode = false
    var bounds: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bounds = goBtn.bounds
        imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
        
        for _ in 0...100 {
            self.dataArray1.append((Int)(arc4random() % 10 ))
            self.dataArray2.append((Int)(arc4random() % 10 ))
            self.dataArray3.append((Int)(arc4random() % 10 ))
        }
        
        myLabel.text = ""
        
        myPickerView.delegate = self
        myPickerView.dataSource = self
        
        goBtn.layer.cornerRadius = 6
        goBtn.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        goBtn.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            
            self.goBtn.alpha = 1
            
        }, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 開外掛用的 目前沒使用
    @IBAction func cheatButtonDidTouch(_ sender: UIButton) {
        cheatMode = !cheatMode
        sender.setTitle(cheatMode ? "外掛模式":"一般模式", for: .normal)
    }
    
    @IBAction func goButtonDidTouch(_ sender: UIButton){
        
        let index1: Int
        let index2: Int
        let index3: Int
        if cheatMode {
            index1 = Int(arc4random()) % 90 + 3
            index2 = dataArray2.firstIndex(of: dataArray1[index1])!
            index3 = dataArray3.lastIndex(of: dataArray1[index1])!
            
        } else {
            index1 = Int(arc4random()) % 90 + 3
            index2 = Int(arc4random()) % 90 + 3
            index3 = Int(arc4random()) % 90 + 3
        }
        
        myPickerView.selectRow(index1, inComponent: 0, animated: true)
        myPickerView.selectRow(index2, inComponent: 1, animated: true)
        myPickerView.selectRow(index3, inComponent: 2, animated: true)
        
        
        if(dataArray1[myPickerView.selectedRow(inComponent: 0)] == dataArray2[myPickerView.selectedRow(inComponent: 1)] && dataArray2[myPickerView.selectedRow(inComponent: 1)] == dataArray3[myPickerView.selectedRow(inComponent: 2)]) {
            
            myLabel.text = "Bingo!"
            
        } else {
            
            myLabel.text = "Lose"
            
        }
        
        
        //animate
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {
            
            self.goBtn.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width - 20, height: self.bounds.size.height)
            
        }, completion: { (compelete: Bool) in
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions(), animations: {
                
                self.goBtn.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
                
            }, completion: nil)
            
        })
    }
}

extension P2ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK:UIPickerViewDataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // MARK:UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if component == 1 {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
}
