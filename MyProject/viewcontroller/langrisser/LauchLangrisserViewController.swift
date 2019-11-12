//
//  LauchLangrisserViewController.swift
//  MyProject
//
//  Created by Ben on 2019/11/6.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class LauchLangrisserViewController: UIViewController{
    
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnime()
    }
    
    func setAnime(){
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut, .repeat, .autoreverse], animations: {
            
            self.myButton.alpha = 0
            
        }, completion: nil)
    }
}
