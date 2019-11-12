//
//  P5ViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/25.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class P5ViewController: UIViewController{
    
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextView.delegate = self
    }
}

extension P5ViewController : UITextViewDelegate {
    // MARK:UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextLength = text.count - range.length + myTextView.text.count
        if inputTextLength > 140 {
            return false
        }
        myLabel.text = "\(140 - inputTextLength)"
        return true
    }
}
