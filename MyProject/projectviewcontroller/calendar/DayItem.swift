//
//  DayItem.swift
//  MyProject
//
//  Created by Ben on 2019/10/29.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class DayItem{
    var mDate: Date
    var mDayText: String{
        return "\(Calendar.current.component(.day, from: mDate))"
    }
    var mIcon = ""
    
    init(date: Date, icon: String){
        self.mDate = date
        self.mIcon = icon
    }
}
