//
//  ECDate.swift
//  ec-calendar
//
//  Created by Hugo on 19/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

struct Day {
    var day = 0;
    var weekday = 0;
}

struct ECDay {
    var year: Int
    var month: Int
    var day: Int
    var weekDay: Int
    var events: [ECEvent]
    
    init(year:Int, month:Int, day:Int) {
        self.year = year;
        self.month = month;
        self.day = day;
        self.events = [];
        self.weekDay = -1;
    }
    
    func toString() -> String {
        let monthStr = (month < 10) ? "0\(month+1)" : "\(month+1)";
        let dayStr = (day < 10) ? "0\(day)" : "\(day)";
        return "\(year)/\(monthStr)/\(dayStr)"
    }
    
    func idString() -> String {
        let monthStr = (month < 10) ? "0\(month)" : "\(month)";
        let dayStr = (day < 10) ? "0\(day)" : "\(day)";

        return "\(year)\(monthStr)\(dayStr)"
    }
}

struct ECEvent: Codable {
    var title: String
    var location: String
    var remark: String
    var addCalendar: Bool
    var startDate: Date?
    var endDate: Date?
    
    
    init(title: String, location: String, remark: String) {
        self.title = title;
        self.location = location;
        self.remark = remark;
        self.addCalendar = false;
    }
    
}


enum WeekDays: Int {
    case Mon = 1
    case Tue = 2
    case Wed = 3
    case Thu = 4
    case Fri = 5
    case Sat = 6
    case Sun = 7
}

enum LocalDataKey: String {
    case Event = "event"
}

//class ECEvnet: NSObject, NSCoding {
//    var title: String
//    var location: String
//    var remark: String
//    var addCalendar: Bool
//}

class ECDate {
    var month = "";
    var totalDay = 0;
    var day: Array<Day> = [];
    var currWeekday = 1;
    
    init(month: String, totalDay: Int) {
        self.month = month;
        self.totalDay = totalDay;
    }
    
    func initDays() -> Void {
        for today in 1...totalDay+1 {
            day.append(Day(day: today, weekday: currWeekday));
            currWeekday += 1;
            if (currWeekday > 7)
            {
                currWeekday = 1;
            }
        }
    }
    
    func calculateWeekdays(lastWeekday: Int) -> Int {
        
        for _ in 0 ..< skipDay(weekday: WeekDays(rawValue: lastWeekday)!) {
            day.append(Day(day: -1, weekday: -1));
        }
        currWeekday = lastWeekday;
        
        for today in 1 ... totalDay {
            day.append(Day(day: today, weekday: currWeekday));
            
            currWeekday += 1;
            
            
            if (currWeekday > 7)
            {
                currWeekday = 1;
            }
            
        }
        
        
        return currWeekday;

    }
    
    func skipDay(weekday:WeekDays) -> Int {
        switch weekday {
        case WeekDays.Sun:
            return 0;
        case WeekDays.Mon:
            return 1;
        case WeekDays.Tue:
            return 2;
        case WeekDays.Wed:
            return 3;
        case WeekDays.Thu:
            return 4;
        case WeekDays.Fri:
            return 5;
        case WeekDays.Sat:
            return 6;
        }
    }
}
