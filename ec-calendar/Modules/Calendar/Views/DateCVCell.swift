//
//  DateCVCell.swift
//  ec-calendar
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

struct CalendarDate {
    var year: Int
    var month: Int
    var day: Int
}

class DateCVCell: UICollectionViewCell {
    
    let lblDate: UILabel = {
        let lbl                 = UILabel()
        lbl.numberOfLines       = 0
        lbl.text                = "32"
        
        return lbl
    }()
    
    let event: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        view.layer.cornerRadius = 5/2;
        view.clipsToBounds = true;
        return view;
    }()
    
    public
        var date: CalendarDate?
        var today: Date?
    
    var isWeekend: Bool = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.contentView.addSubview(lblDate)
        self.contentView.addSubview(event)
        
        self.contentView.layer.borderWidth  = 1.0
        self.contentView.layer.borderColor  = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = frame.size.width / 2
        self.contentView.clipsToBounds      = true
        
        
        lblDate.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
        }
        
        event.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView).offset(15)
            make.size.equalTo(5)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        lblDate.textColor = UIColor.black;
        
    }
    
    
    func checkWeekDay(date:CalendarDate) -> Void {
        isWeekend = false;
        
        let format          = DateFormatter();
        format.dateFormat   = "yyyy-MM-dd";
        
        let dateStr: String = "\(date.year)-\(date.month)-\(date.day)";
        guard let currDate: Date = format.date(from: dateStr) else { return };
        
        today = currDate;
        
        let weekday = NSCalendar.current.component(.weekday, from: currDate);
        // 1 = Sunday, 2 = Monday, etc
        if (weekday == 1 || weekday == 7)
        {
            isWeekend = true;
        }
        
    }

    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showEvetn() -> Void {
        event.backgroundColor = UIColor.lightGray;
    }
}
