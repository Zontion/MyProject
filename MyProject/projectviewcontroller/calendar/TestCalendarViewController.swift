//
//  TestCalendarViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/31.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class TestCalendarViewController: UIViewController{
    
    var calendarView: CalendarViewController!
    @IBOutlet weak var tryBtn: UIButton!
    @IBOutlet weak var calendarContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowCalendar"{
//            if let childVC = segue.destination as? CalendarViewController{
//                self.calendarView = childVC
//                self.calendarView.calendarViewDelegate = self
//            }
//        }
//    }
    
    private func setupChildViewControllers(){
        let storyboard = UIStoryboard(name: "Project", bundle: nil)
        
        self.calendarView = storyboard.instantiateViewController(withIdentifier:"CalendarView") as? CalendarViewController
        
        //addChild(calendarView!)
        calendarView.view.frame = calendarContainer.bounds
        self.calendarContainer.addSubview(calendarView.view)

        self.calendarView.calendarViewDelegate = self
        
    }
    
    @IBAction func tryLastClick(_ sender: Any){
        calendarView.superCall()
    }
}

extension TestCalendarViewController: CalendarViewDelegate{
    func lastBtnClicked(date: Date) {
        print("上個月是\(date)")
    }
    
    func nextBtnClicked(date: Date) {
        print("下個月是\(date)")
    }
    
    func calendarCellClicked(dayItem: DayItem) {
        let aaa = date2GMT8string(date: dayItem.mDate)
        print("點擊日期為\(aaa)")
        print("點擊事件為\(dayItem.mIcon)")
    }
    
    func date2GMT8string(date: Date) -> String{
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") // 設定地區(台灣)
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei") // 設定時區(台灣)
        return dateFormatter.string(from: date)
    }
}
