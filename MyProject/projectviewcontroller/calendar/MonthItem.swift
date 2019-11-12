//
//  MonthItem.swift
//  MyProject
//
//  Created by Ben on 2019/10/28.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class MonthItem{
    var mThisMonthList: [DayItem] = []
    var mLastMonthList: [DayItem] = []
    var mNextMonthList: [DayItem] = []
    
    init(dayItem: DayItem, eventList: [String]){
        let firstDayOfMonth = getFirstDayOfMonth(dayItem: dayItem)
        self.mThisMonthList = getThisMonthList(dayItem: dayItem, firstDayOfMonth: firstDayOfMonth, eventList: eventList)
        self.mLastMonthList = getLastMonthList(dayItem: dayItem, firstDayOfMonth: firstDayOfMonth, eventList: eventList)
        self.mNextMonthList = getNextMonthList(dayItem: dayItem, eventList: eventList)
    }
    
    // 取得本月列表
    func getThisMonthList(dayItem: DayItem, firstDayOfMonth: Date, eventList: [String]) -> [DayItem]{
        var thisMonthList: [DayItem] = []
        let numberOfMonth = getNumberOfMonth(date: dayItem.mDate)
        for i in 0..<numberOfMonth{
            let nextDay = getNextDay(date: firstDayOfMonth, day: i)
            for j in 0..<eventList.count{
                if Calendar.current.isDate(nextDay, inSameDayAs: string2Date(eventList[j])){
                    thisMonthList.append(DayItem(date: nextDay, icon: "●"))
                    break;
                } else if j == eventList.count - 1{
                    thisMonthList.append(DayItem(date: nextDay, icon: ""))
                }
            }
        }
        return thisMonthList
    }
    
    // 取得上個月列表
    func getLastMonthList(dayItem: DayItem, firstDayOfMonth: Date, eventList: [String]) -> [DayItem]{
        var lastMonthList: [DayItem] = []
        let firstDayOfWeek = Calendar.current.component(.weekday, from: firstDayOfMonth)
        if firstDayOfWeek > 1{
            for i in 1..<firstDayOfWeek{
                let lastDay = getLastDay(date: firstDayOfMonth, day: (firstDayOfWeek - i))
                for j in 0..<eventList.count{
                    if Calendar.current.isDate(lastDay, inSameDayAs: string2Date(eventList[j])){
                        lastMonthList.append(DayItem(date: lastDay, icon: "●"))
                        break;
                    } else if j == eventList.count - 1{
                        lastMonthList.append(DayItem(date: lastDay, icon: ""))
                    }
                }
            }
        }
        return lastMonthList
    }
    
    // 取得下個月列表
    func getNextMonthList(dayItem: DayItem, eventList: [String]) -> [DayItem]{
        var nextMonthList: [DayItem] = []
        
        let dayCountOfNext = 42 - (self.mLastMonthList.count + self.mThisMonthList.count)
        if dayCountOfNext > 0{
            for i in 1...dayCountOfNext{
                let nextDay = getNextDay(date: self.mThisMonthList[mThisMonthList.count - 1].mDate, day: i)
                for j in 0..<eventList.count{
                    if Calendar.current.isDate(nextDay, inSameDayAs: string2Date(eventList[j])){
                        nextMonthList.append(DayItem(date: nextDay, icon: "●"))
                        break;
                    } else if j == eventList.count - 1{
                        nextMonthList.append(DayItem(date: nextDay, icon: ""))
                    }
                }
            }
        }
        return nextMonthList
    }
    
    // 取得本月第一天
    func getFirstDayOfMonth(dayItem: DayItem) -> Date{
//        print("第一天是\(Calendar.current.component(.weekday, from: dayItem.mDate))")
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: dayItem.mDate)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    // 本月開始日期
    func startOfCurrentMonth(date: Date) -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        let firstOfMonth = calendar.date(from: components)!
        return firstOfMonth
    }
    
    // 取得當月有幾天
    func getNumberOfMonth(date: Date) -> Int{
        let range = Calendar.current.range(of: .day, in: .month, for: date)
//        print("當月有\(range?.count ?? 0)天")
        return range?.count ?? 0
    }
    
    // 取得隔天
    func getNextDay(date: Date, day: Int) -> Date{
        return date.addingTimeInterval(TimeInterval(day * 24*60*60))
    }
    
    // 取得前一天
    func getLastDay(date: Date, day: Int) -> Date{
        return date.addingTimeInterval(TimeInterval(day * -24*60*60))
    }
    
    // 取得畫面資料總數 (上月月底 + 本月天數 + 下月月初)
    func getNumberOfAll() -> Int{
        return (mLastMonthList.count + mThisMonthList.count + mNextMonthList.count)
    }
    
    // 字串轉日期
    func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
}
