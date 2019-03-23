//
//  DiaryPickDateView.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 23/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class DiaryPickDateView: UIView,UIPickerViewDelegate,UIPickerViewDataSource{
    
    var doubleSunday: Bool!
    var year: Int = 1
    var month: Int = 1
    var day: Int = 1
    var totalDay :Int = 0


    var leftDay: UIPickerView!
    var leftDayViewDataSize:Int!
    var leftDayViewData = [Int]()
    
    var centerMonth: UIPickerView!
    var centerMonthViewDataSize:Int!
    var centerMonthViewData = [Int]()
    
    var rightYear: UIPickerView!
    var rightYearViewDataSize:Int!
    var rightYearViewData = [Int]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func afterInit() {
        doubleSunday = true
        setUpDateData(doubleSunday: doubleSunday)
        setUpDayView()
        setUpMonthView()
        setUpYearView()
    }
    
    func reCalDay(doubleSunday:Bool,year:Int,month:Int){
        if doubleSunday {
            if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0 && year % 3200 != 0){
                switch month{
                case 1,3,5,7,8,10,12:
                    totalDay = 31
                case 4,6,11:
                    totalDay = 30
                default:
                    totalDay = 29
                }
            }else{
                switch month{
                case 1,5,7,8,10,12:
                    totalDay = 31
                case 3,4,6,9,11:
                    totalDay = 30
                default:
                    totalDay = 29
                }
            }
        }else{
            if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0 && year % 3200 != 0){
                switch month{
                case 1,3,5,7,8,10,12:
                    totalDay = 31
                case 4,6,9,11:
                    totalDay = 30
                default:
                    totalDay = 29
                }
            }else{
                switch month{
                case 1,3,5,7,8,10,12:
                    totalDay = 31
                case 4,6,9,11:
                    totalDay = 30
                default:
                    totalDay = 28
                }
            }
        }
        leftDayViewData.removeAll()
        for d in 1...totalDay{
            leftDayViewData.append(d)
        }
    }
    
    func setUpDateData(doubleSunday:Bool) {
        
        reCalDay(doubleSunday: doubleSunday, year: year, month: month)
        
        for m in 1...12{
            centerMonthViewData.append(m)
        }
        for y in 1...2500{
            rightYearViewData.append(y)
        }
        
        
    }
    
    func setUpDayView() {
        leftDay = UIPickerView()
        leftDay.dataSource = self
        leftDay.delegate = self
        leftDay.frame = CGRect(x: 0, y: 0, width: self.frame.width/3, height: 60)
        print(self.frame.width/3)
        
        self.addSubview(leftDay)
        leftDay.selectRow(day-1, inComponent: 0, animated: false)
        
        
    }
    
    func setUpMonthView() {
        centerMonth = UIPickerView()
        centerMonth.dataSource = self
        centerMonth.delegate = self
        centerMonth.frame = CGRect(x: self.frame.width/3, y: 0, width: self.frame.width/3, height: 60)
        
        self.addSubview(centerMonth)
        centerMonth.selectRow(month-1, inComponent: 0, animated: false)
        
        
    }
    
    
    func setUpYearView() {
        rightYear = UIPickerView()
        rightYear.dataSource = self
        rightYear.delegate = self
        rightYear.frame = CGRect(x: self.frame.width*2/3, y: 0, width: self.frame.width/3, height: 60)
        
        self.addSubview(rightYear)
        
        rightYear.selectRow(year-1, inComponent: 0, animated: false)
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == leftDay{
            return leftDayViewData.count
        }else if pickerView == centerMonth{
            return centerMonthViewData.count
        }else if pickerView == rightYear{
            return rightYearViewData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == leftDay{
            return String(leftDayViewData[row])
        }else if pickerView == centerMonth{
            return String(centerMonthViewData[row])
        }else if pickerView == rightYear{
            return String(rightYearViewData[row])
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var m = month
        var y = year
        if pickerView == centerMonth {
            m = centerMonthViewData[row]
        }else if pickerView == rightYear {
            y = rightYearViewData[row]
        }
        reCalDay(doubleSunday: doubleSunday, year: y, month: m)
        leftDay.reloadAllComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
