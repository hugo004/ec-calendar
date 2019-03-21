//
//  DateCVCell.swift
//  ec-calendar
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit


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
        var today: ECDay?
    
    var isWeekend: Bool = false;
    var isToday: Bool = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.clipsToBounds      = true
        self.contentView.layer.borderColor  = UIColor.lightGray.cgColor

        
        normalStyle();

        self.contentView.addSubview(lblDate)
        self.contentView.addSubview(event)
        
        
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
        isWeekend = false;
        isToday = false;
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func circleStyle() -> Void {
        self.contentView.layer.borderWidth  = 1.0
        self.contentView.layer.cornerRadius = frame.size.width / 2
    }
    
    func normalStyle() -> Void {
        self.contentView.layer.borderWidth  = 0
        self.contentView.layer.cornerRadius = 10;
    }
    
    func highlighSunDay() -> Void {
        lblDate.textColor = UIColor.red;
        self.contentView.backgroundColor = UIColor.white;

    }
    
    func hightlightToday(events: [ECEvent]) -> Void {
        
        let year: Int = Calendar.current.component(.year, from: Date());
        let month: Int = Calendar.current.component(.month, from: Date()) - 1; //calendar month follow index start from 0..
        let day: Int = Calendar.current.component(.day, from: Date());
       let current = ECDay(year: year, month: month, day: day);
        
        if (
            today?.day == current.day &&
            today?.month == current.month &&
            today?.year == current.year
        )
        {
            today?.events = events;
            isToday = true;
            hightlightToday();
        }
        else
        {
            unhightlight();
        }
    }
    
    func hightlightToday() -> Void {
        
        self.contentView.backgroundColor = UIColor(red:0.65, green:0.78, blue:0.32, alpha:1.0);
        lblDate.textColor = UIColor.white;
    }
    
    func eventMark() -> Void {
        if today?.events.count ?? 0 > 0
        {
            event.backgroundColor = UIColor.lightGray;
        }
        else
        {
            event.backgroundColor = UIColor.clear;
        }
    }
    
    func unhightlight() -> Void {
        self.contentView.backgroundColor = UIColor.white
        lblDate.textColor = UIColor.black;
    }
    
    func hightlight() -> Void {
        self.contentView.backgroundColor = UIColor(red:0.20, green:0.69, blue:0.79, alpha:1.0);
        lblDate.textColor = UIColor.white;
    }
    
    
    override var isSelected: Bool {
        didSet
        {
            if self.isSelected
            {
                hightlight();
            }
            else
            {
                if today?.weekDay == 7
                {
                    highlighSunDay();
                }
                else if isToday
                {
                    hightlightToday();
                }
                else
                {
                    unhightlight();

                }
            }
        }
    }
}
