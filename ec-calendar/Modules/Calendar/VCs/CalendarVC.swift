//
//  CalendarVC.swift
//  ec-calendar
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import ReactiveCocoa
import UIKit

private let identifier = "Cell"
private let header = "header"

struct Month {
    var month: String
    var day: Int
}

class CalendarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    var cv: UICollectionView!
    var header: MonthHeaderView!
    var ecDate: [ECDate]!

    var currMonth = 0

    var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white

        initCalendarDataSource()
        initCollectionView()
        initTableView()
    }
    
    func isLeapYear() -> Bool {
        let year:Int = Calendar.current.component(.year, from: Date());
        
        return (year % 100 != 0) && (year % 4 == 0) || (year % 400 == 0);
    }

    func initCalendarDataSource() {
        
        ecDate = [];
        var startWeekday = 1
        
        let marTotalDay = isLeapYear() ? 31 : 30; //ec calendar set march total for leap year instead of feb, feb awayls 29 total

        let monthDict = [
            (name:"Jan", days:31),
            (name:"Feb", days:29),
            (name:"Mar", days:marTotalDay),
            (name:"Apr", days:30),
            (name:"May", days:31),
            (name:"Jun", days:30),
            (name:"Jul", days:31),
            (name:"Aug", days:31),
            (name:"Sep", days:30),
            (name:"Oct", days:31),
            (name:"Nov", days:30),
            (name:"Dec", days:31)
        ];
        for month in monthDict {
            let myDate = ECDate(month: month.name, totalDay: month.days);
            startWeekday = myDate.calculateWeekdays(lastWeekday: startWeekday);
            
            if myDate.day.last?.weekday == 7 {
                startWeekday = 7
            }
            
            ecDate.append(myDate);

        }
        
    }

    func initCollectionView() {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: 50, height: 50)
        flowlayout.minimumInteritemSpacing = 0 // horizontal line space between items
        flowlayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: 40)
        

        cv = UICollectionView(frame: view.bounds, collectionViewLayout: flowlayout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        cv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)

        cv.register(DateCVCell.self, forCellWithReuseIdentifier: identifier)
        cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        header = MonthHeaderView(frame: CGRect(x: 0, y: 10, width: view.frame.size.width, height: 50))
        header.backgroundColor = UIColor.white
        header.layer.borderWidth = 1.0
        header.layer.borderColor = UIColor.lightText.cgColor
        header.lblMonth.text = ecDate[currMonth].month

        // click event
        header.left.reactive.controlEvents(UIControl.Event.touchUpInside).observeValues { _ in
            self.currMonth -= 1

            if self.currMonth < 0 {
                self.currMonth = 11
            }
            self.header.lblMonth.text = self.ecDate[self.currMonth].month
            self.cv.reloadData()
        }

        header.right.reactive.controlEvents(UIControl.Event.touchUpInside).observeValues { _ in
            self.currMonth += 1

            if self.currMonth > 11 {
                self.currMonth = 0
            }
            self.header.lblMonth.text = self.ecDate[self.currMonth].month
            self.cv.reloadData()
        }

        view.addSubview(header)
        view.addSubview(cv)

        cv.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.width.bottom.equalTo(self.view)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ecDate[currMonth].day.count;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DateCVCell

        let today: Day = ecDate[currMonth].day[indexPath.row];
        
        if today.day < 0 {
            cell.isHidden = true;
        }else {
            cell.lblDate.text = String(ecDate[currMonth].day[indexPath.row].day)
            cell.isHidden = false;
            
            if today.weekday == 7 {
                cell.lblDate.textColor = UIColor.white;
                cell.contentView.backgroundColor = UIColor.red;
            }else {
                cell.lblDate.textColor = UIColor.black;
                cell.contentView.backgroundColor = UIColor.white;

            }
        }
        

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCVCell
        cell.showEvetn()
        let vc = DayVC()
        vc.today = cell.today
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader)
        {
            let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            
            weekendTitleView(header: header);
            
            return header;
        }
        
        return UICollectionReusableView();
    }
    
    func weekendTitleView(header:UIView) {
        var sun, mon, tue, wed, thu, fri, sat: UILabel!;
        
        sun = UILabel();
        sun.text = "Sun";
        sun.textColor = UIColor.red;
        sun.textAlignment = .center;
        
        
        mon = UILabel();
        mon.text = "Mon";
        mon.textColor = UIColor.black;
        mon.textAlignment = .center;

        tue = UILabel();
        tue.text = "Tue";
        tue.textColor = UIColor.black;
        tue.textAlignment = .center;

        
        wed = UILabel();
        wed.text = "Wed";
        wed.textColor = UIColor.black;
        wed.textAlignment = .center;

        thu = UILabel();
        thu.text = "Thu";
        thu.textColor = UIColor.black;
        thu.textAlignment = .center;

        fri = UILabel();
        fri.text = "Fri";
        fri.textColor = UIColor.black;
        fri.textAlignment = .center;

        sat = UILabel();
        sat.text = "Sat";
        sat.textColor = UIColor.black;
        sat.textAlignment = .center;

        header.addSubview(sun);
        header.addSubview(mon);
        header.addSubview(tue);
        header.addSubview(wed);
        header.addSubview(thu);
        header.addSubview(fri);
        header.addSubview(sat);
        
        let width = cv.frame.size.width - 20; //content inset of left (10), right (10);
        
        sun.snp.makeConstraints { (make) in
            make.top.left.equalTo(header);
            make.size.equalTo(CGSize(width: width/7, height: 30));
        }
        
        mon.snp.makeConstraints { (make) in
            make.top.size.equalTo(sun);
            make.left.equalTo(sun.snp.right)
        }
        
        tue.snp.makeConstraints { (make) in
            make.top.size.equalTo(sun);
            make.left.equalTo(mon.snp.right)
            
        }
        
        wed.snp.makeConstraints { (make) in
            make.top.size.equalTo(sun);
            make.left.equalTo(tue.snp.right)
            
        }
        
        thu.snp.makeConstraints { (make) in
            make.top.size.equalTo(sun);
            make.left.equalTo(wed.snp.right)
        }
        
        fri.snp.makeConstraints { (make) in
            make.top.size.equalTo(sun);
            make.left.equalTo(thu.snp.right)
        }
        
        sat.snp.makeConstraints { (make) in
            make.top.size.equalTo(sun);
            make.left.equalTo(fri.snp.right);
        }
        
    }


    //MARK: - tableview datasource,delegate
    func initTableView() {
        tableview = UITableView(frame: CGRect(x: 0,
                                              y: cv.frame.origin.y,
                                              width: view.frame.size.width,
                                              height: view.frame.size.height - cv.frame.size.height),
                                style: .grouped)

        view.addSubview(tableview)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell: UITableViewCell! = tableview.dequeueReusableCell(withIdentifier: identifier)

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell.accessoryType = .detailButton
        }

        return cell
    }
    
}
