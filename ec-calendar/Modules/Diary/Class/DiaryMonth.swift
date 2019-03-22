//
//  DiaryMonth.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 20/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

struct DiaryMonth: Codable {
    var month: String
    var diaryDays: [Diary]
    
    init(month:String,diaryDays:[Diary]) {
        self.month = month
        self.diaryDays = diaryDays
    }
    
}
