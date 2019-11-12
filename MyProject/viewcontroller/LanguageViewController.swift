//
//  LanguageViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/18.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController{
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = NSLocalizedString("Text", tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
    
    
}
