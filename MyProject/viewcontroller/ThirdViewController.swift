//
//  ThirdViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/15.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let day = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    
    let time = ["早上", "下午", "晚上"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //設定各個component內的項目數量
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //如果是第一列，就回傳Day的數量
        if component == 0{
            return day.count
        } else {
            //否則 回傳time的數量
            return time.count
        }
    }
    
    //設定每個項目的名稱
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if component == 0{
            return day[row]
        } else {
            return time[row]
        }
    }
    
    
    @IBOutlet weak var pickView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickView.delegate = self
        self.pickView.dataSource = self
    }
}
