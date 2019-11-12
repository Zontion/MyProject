//
//  ViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/9.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //calcu()
    }
    
    private func calcu(){
        for i in 0...9{
            for j in 0...9{
                print("\(i)X\(j)=\(i*j)")
    
            }
        }
    }
    
    @IBAction func showMessage(sender: UIButton){
        // sender 是使用者所按下的按鈕
        // 這裡我們將 sender 儲存至 selectedButton constant
        let selectedButton = sender
        
        // 從所選按鈕的標題標籤取得表情符號
        if (selectedButton.titleLabel?.text) != nil{
            // 從字典取得表情符號的意義
            // 程式碼填入至下方
            
            
            
            // 變更以下這行程式將 Hello World 的顯示以來表情符號的意義來取代
            let alertController = UIAlertController(title: "Meaning", message: "meaning", preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func showLogin(sender: UIButton){
        let load = UIAlertController.init(title: "登入", message: "請輸入帳密", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .destructive, handler: nil)
        
        let okaction = UIAlertAction.init(title: "確定", style: .default, handler: nil)
        load.addTextField { (textfield) in
            textfield.placeholder = "帳號"
        }
        load.addTextField { (textfield) in
            textfield.placeholder = "密碼"
            textfield.isSecureTextEntry = true
            load.addAction(okaction)
            load.addAction(cancelAction)
        }
        
        present(load, animated: true, completion: nil)
    }
    
    @IBAction func showBottom(sender: UIButton){
        let alert = UIAlertController.init(title: "底部彈出", message: "從底部彈出", preferredStyle: .actionSheet)
        
        let okaction = UIAlertAction.init(title: "確定", style: .default, handler: nil)
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .destructive, handler: nil)
        
        alert.addAction(okaction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func toSecond(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToSecond", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let controller = segue.destination as? SecondViewController
        
        if let button = sender as? UIButton{
            switch button.tag{
            case 0:
                controller?.text = "Button1"
                break
            case 1:
                controller?.text = "Button2"
                break
            default:
                break
            }
        }
    }
}

