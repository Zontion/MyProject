//
//  AFKDetailViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/24.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class AFKDetailViewController: UIViewController{
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var afkCharacter :AFKCharacter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    
    func setData(){
        self.detailLabel.numberOfLines = 0
        
        self.detailLabel.text = afkCharacter.description
    }
}
