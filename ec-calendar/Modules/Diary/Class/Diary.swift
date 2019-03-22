//
//  DiaryController.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

struct Diary{
    var date: Date
    var week: String
    var weather: String
    var content: String
    var title: String
    var image: UIImage?
    
    init(date:Date,week:String,weather:String,content:String,title:String,image:UIImage) {
        self.date = date
        self.week = week
        self.weather = weather
        self.content = content
        self.title = title
        self.image = image
    }
    
}
