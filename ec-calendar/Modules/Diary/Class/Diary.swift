//
//  DiaryController.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

struct Diary: Codable{
    var year :Int
    var month :Int
    var day :Int
    var weather: String
    var content: String
    var title: String
    var image: Data
    
    init(year:Int,month:Int,day:Int,weather:String,content:String,title:String,image:UIImage) {
        self.year = year
        self.month = month
        self.day = day
        self.weather = weather
        self.content = content
        self.title = title
        self.image = image.pngData()!;
    }
    
    func toString() -> String {
        let monthStr = (month < 10) ? "0\(month)" : "\(month)";
        let dayStr = (day < 10) ? "0\(day)" : "\(day)";
        return "\(year)/\(monthStr)/\(dayStr)"
    }
    
    func getMonth() -> Int {
        return month
    }
    func getDay() -> Int {
        return day
    }
    func getYear() -> Int {
        return year
    }
    
}
