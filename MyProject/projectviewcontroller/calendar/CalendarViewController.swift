//
//  CalendarView.swift
//  MyProject
//
//  Created by Ben on 2019/10/30.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol CalendarViewDelegate: class {
    func lastBtnClicked(date: Date)
    func nextBtnClicked(date: Date)
    func calendarCellClicked(dayItem: DayItem)
}

class CalendarViewController: UIViewController{
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let numberOfMonths = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    let eventList = ["2019-10-01", "2019-10-28", "2019-09-15"]
    
    @IBOutlet weak var lastBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var calendarViewDelegate: CalendarViewDelegate?
    
    var today = Date() // 今天
    var currentDate = Date() // 當日Date
    var choiceDate: Date? // 選擇日期
    var currentDay = 0 // 當日
    var currentMonth = 0 // 當月
    var currentYear = 0 // 當年
    
    var dayItem: DayItem?
    var monthItem: MonthItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myCollectionView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: "dayCell")
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        setUp()
    }
    
    func setUp(){
        
        // 當日
        currentDay = Calendar.current.component(.day, from: currentDate)
        
        // 當月
        currentMonth = Calendar.current.component(.month, from: currentDate)
        
        // 當年
        currentYear = Calendar.current.component(.year, from: currentDate)
        
        dayItem = DayItem(date: currentDate, icon: "")
        monthItem = MonthItem(dayItem: dayItem!, eventList: eventList)
        dateLabel.text = "\(currentYear)年\(numberOfMonths[currentMonth-1])月"
        
        myCollectionView.reloadData()
    }
    
    func superCall(){
        print("superCall")
        self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
        setUp()
    }
    
    @IBAction func lastMonth(_ sender: Any) {
        self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
        setUp()
        self.calendarViewDelegate?.lastBtnClicked(date: self.currentDate)
    }
    @IBAction func nextMonth(_ sender: Any) {
        self.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentDate)!
        setUp()
        self.calendarViewDelegate?.nextBtnClicked(date: self.currentDate)
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarViewCell
        
        // 清除全部紅框
        for singleCell in myCollectionView.visibleCells{
            cancelCellBorder(cell: singleCell as! CalendarViewCell)
        }
        
        // 將選擇的設定紅框
        setCellBorder(cell: cell, color: UIColor.red.cgColor)
        
        self.choiceDate = cell.dayItem!.mDate
        
        self.calendarViewDelegate?.calendarCellClicked(dayItem: cell.dayItem!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as? CalendarViewCell else {
            return UICollectionViewCell()
        }
        
        if monthItem!.mLastMonthList.count > indexPath.row{
            
            setLastMonthCell(cell: cell, indexPath: indexPath)
            
        } else if monthItem!.mThisMonthList.count > (indexPath.row - monthItem!.mLastMonthList.count){
            
            setThisMonthCell(cell: cell, indexPath: indexPath)
            
        } else if monthItem!.mThisMonthList.count > (indexPath.row - monthItem!.mLastMonthList.count - monthItem!.mThisMonthList.count){
            
            setNextMonthCell(cell: cell, indexPath: indexPath)
            
        }
        
        return cell
    }
    
    // 設定上月底cell
    func setLastMonthCell(cell: CalendarViewCell, indexPath: IndexPath){
        let day: DayItem = monthItem!.mLastMonthList[indexPath.row]
        cell.dayLabel.text = day.mDayText
        // 可在此用day的mDate加入判斷是否假日(紅色)
        cell.dayLabel!.textColor = UIColor.lightGray
        cell.contextLabel!.text = day.mIcon
        
        setBorderWithCheckChoice(cell: cell, date: day.mDate)
        
        cell.dayItem = day
//        print(cell.dayItem!.mDayText)
//        print(cell.dayItem!.mDate)
    }
    
    // 設定本月cell
    func setThisMonthCell(cell: CalendarViewCell, indexPath: IndexPath){
        let day: DayItem = monthItem!.mThisMonthList[indexPath.row - monthItem!.mLastMonthList.count]
        cell.dayLabel.text = day.mDayText
        cell.dayLabel!.textColor = UIColor.black    // 可在此用day的mDate加入判斷是否假日(紅色)
        cell.contextLabel!.text = day.mIcon
        
        if Calendar.current.isDate(self.today, inSameDayAs: day.mDate){
            cell.dayLabel.textColor = UIColor.red
        } else {
            cell.dayLabel.textColor = UIColor.black
        }
        
        setBorderWithCheckChoice(cell: cell, date: day.mDate)
        
        cell.dayItem = day
//        print(cell.dayItem!.mDayText)
//        print(cell.dayItem!.mDate)
    }
    
    // 設定下月月初cell
    func setNextMonthCell(cell: CalendarViewCell, indexPath:IndexPath){
        
        let day: DayItem = monthItem!.mNextMonthList[indexPath.row - monthItem!.mLastMonthList.count - monthItem!.mThisMonthList.count]
        cell.dayLabel.text = day.mDayText
        // 可在此用day的mDate加入判斷是否假日(紅色)
        cell.dayLabel!.textColor = UIColor.lightGray
        cell.contextLabel!.text = day.mIcon
        
        setBorderWithCheckChoice(cell: cell, date: day.mDate)
        
        cell.dayItem = day
//        print(cell.dayItem!.mDayText)
//        print(cell.dayItem!.mDate)
    }
    
    func setBorderWithCheckChoice(cell: CalendarViewCell, date: Date){
        cancelCellBorder(cell: cell)
        
        if self.choiceDate != nil{
            if Calendar.current.isDate(self.choiceDate!, inSameDayAs: date){
                setCellBorder(cell: cell, color: UIColor.red.cgColor)
            }
        }
    }
    
    // 設定cell背景顏色
    func setCellBGColor(cell: CalendarViewCell, color: UIColor){
        cell.backgroundColor = color
    }
    
    // 設定cell邊框
    func setCellBorder(cell: CalendarViewCell, color: CGColor){
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = color
        cell.layer.cornerRadius = 10
    }
    
    // 取消cell邊框
    func cancelCellBorder(cell: CalendarViewCell){
        setCellBorder(cell: cell, color: UIColor.white.cgColor)
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width:width, height: 50)
    }
}

