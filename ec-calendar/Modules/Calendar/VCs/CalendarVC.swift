//
//  CalendarVC.swift
//  ec-calendar
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import ReactiveCocoa

private let identifier  = "Cell"
private let header      = "header"

struct Month {
    var month: String
    var day:   Int
}

class CalendarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var cv:     UICollectionView!
    var header: MonthHeaderView!
    var months: [Month]!
    
    
    var currMonth   = 0
    var currDay     = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout             = []
        self.view.backgroundColor               = UIColor.white
        
        initCalendarDataSource()
        initView()
    }
    
    func initCalendarDataSource() -> Void {
        months = []
        months.append(Month(month: "Jan", day: 31))
        months.append(Month(month: "Feb", day: 28))
        months.append(Month(month: "Mar", day: 31))
        months.append(Month(month: "Apr", day: 30))
        months.append(Month(month: "May", day: 31))
        months.append(Month(month: "Jun", day: 30))
        months.append(Month(month: "Jul", day: 31))
        months.append(Month(month: "Aug", day: 31))
        months.append(Month(month: "Sep", day: 30))
        months.append(Month(month: "Oct", day: 31))
        months.append(Month(month: "Nov", day: 30))
        months.append(Month(month: "Dec", day: 31))

    }
    
    func initView() -> Void {
        
        let flowlayout                      = UICollectionViewFlowLayout()
        flowlayout.itemSize                 = CGSize(width: 50, height: 50)
        flowlayout.minimumInteritemSpacing  = 0 // horizontal line space between items
        flowlayout.headerReferenceSize      = CGSize(width: self.view.frame.size.width, height: 60)
        
        cv                  = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowlayout)
        cv.delegate         = self
        cv.dataSource       = self
        cv.backgroundColor  = UIColor.white
        cv.contentInset     = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        cv.register(DateCVCell.self, forCellWithReuseIdentifier: identifier)
//        cv.register(MonthHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header)
        
        header                      = MonthHeaderView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 40))
        header.backgroundColor      = UIColor.white
        header.layer.borderWidth    = 1.0
        header.layer.borderColor    = UIColor.lightText.cgColor
        header.lblMonth.text        = months[currMonth].month
        
        //click event
        header.left.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.currMonth -= 1
            self.currDay = 1
            
            if (self.currMonth < 0)
            {
                self.currMonth = 11
            }
            self.header.lblMonth.text = self.months[self.currMonth].month
            self.cv.reloadData()

        }
        
        header.right.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.currMonth += 1
            self.currDay = 1

            if (self.currMonth > 11)
            {
                self.currMonth = 1
                
            }
            self.header.lblMonth.text = self.months[self.currMonth].month
            
        }


        
        self.view.addSubview(header)
        self.view.addSubview(cv)
        
        
        cv.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom)
            make.width.bottom.equalTo(self.view)
        }
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months[currMonth].day
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DateCVCell
        
        cell.lblDate.text   = String(currDay)
        currDay             += 1
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell                = collectionView.cellForItem(at: indexPath) as! DateCVCell
        cell.lblDate.textColor  = UIColor.red
        
    }
    
    
}
