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

enum WeekDays: Int {
    case Mon = 1
    case Tue = 2
    case Wed = 3
    case Thu = 4
    case Fri = 5
    case Sat = 6
    case Sun = 7
}

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
        print(lastWeekday)
        
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
