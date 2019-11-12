//
//  CalendarViewCell.swift
//  MyProject
//
//  Created by Ben on 2019/10/28.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class CalendarViewCell: UICollectionViewCell{
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    
    var dayItem: DayItem?
}
