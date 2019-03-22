//
//  DiaryVC.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

private let header      = "header"
private let identifier  = "Cell"

class DiaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tv : UITableView!
    var header: DiaryMonthHeaderView!
    public var months: [DiaryMonth]!
    var diaryDays1: [Diary]!
    var diaryDays2: [Diary]!
    var diaryDays3: [Diary]!
    var diaryDays4: [Diary]!
    var diaryDays5: [Diary]!
    var diaryDays6: [Diary]!
    var diaryDays7: [Diary]!
    var diaryDays8: [Diary]!
    var diaryDays9: [Diary]!
    var diaryDays10: [Diary]!
    var diaryDays11: [Diary]!
    var diaryDays12: [Diary]!
    
    var currYear = 0
    var currMonth   = 0
    var currDay     = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initDiaryDataSource()
        initView()
        

        // Do any additional setup after loading the view.
    }
    
    func getCurMonth() -> Int{
        let currentDate = Date()
        let curDateForrmat = DateFormatter()
        curDateForrmat.dateFormat = "MM"
    
        return (curDateForrmat.string(from: currentDate) as NSString).integerValue
    }
    
    
    @objc func addDiary()
    {
        let addDiaryVC = AddDiaryVC()
        addDiaryVC.delegate = self
        
        self.navigationController?.pushViewController(addDiaryVC, animated: true)
    }
    
    func initDiaryDataSource() -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date1String = "2019-01-01"
        var dateObj = dateFormatter.date(from: date1String)
        diaryDays1 = []
        diaryDays1.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date2String = "2019-02-01"
        dateObj = dateFormatter.date(from: date2String)
        diaryDays2 = []
        diaryDays2.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date3String = "2019-03-01"
        dateObj = dateFormatter.date(from: date3String)
        diaryDays3 = []
        diaryDays3.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image: UIImage(named:"timg")!))
        
        let date4String = "2019-04-01"
        dateObj = dateFormatter.date(from: date4String)
        diaryDays4 = []
        diaryDays4.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date5String = "2019-05-01"
        dateObj = dateFormatter.date(from: date5String)
        diaryDays5 = []
        diaryDays5.append(Diary(date:dateObj!,week:"Sun",weather:"Bad",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date6String = "2019-06-01"
        dateObj = dateFormatter.date(from: date6String)
        diaryDays6 = []
        diaryDays6.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date7String = "2019-07-01"
        dateObj = dateFormatter.date(from: date7String)
        diaryDays7 = []
        diaryDays7.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date8String = "2019-08-01"
        dateObj = dateFormatter.date(from: date8String)
        diaryDays8 = []
        diaryDays8.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date9String = "2019-09-01"
        dateObj = dateFormatter.date(from: date9String)
        diaryDays9 = []
        diaryDays9.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date10String = "2019-10-01"
        dateObj = dateFormatter.date(from: date10String)
        diaryDays10 = []
        diaryDays10.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date11String = "2019-11-01"
        dateObj = dateFormatter.date(from: date11String)
        diaryDays11 = []
        diaryDays11.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        let date12String = "2019-12-01"
        dateObj = dateFormatter.date(from: date12String)
        diaryDays12 = []
        diaryDays12.append(Diary(date:dateObj!,week:"Sun",weather:"Sun",content:"123",title:"123",image:UIImage(named:"timg")!))
        
        months = []
        months.append(DiaryMonth(month: "Jan",diaryDays:diaryDays1))
        months.append(DiaryMonth(month: "Feb",diaryDays:diaryDays2))
        months.append(DiaryMonth(month: "Mar",diaryDays:diaryDays3))
        months.append(DiaryMonth(month: "Apr",diaryDays:diaryDays4))
        months.append(DiaryMonth(month: "May",diaryDays:diaryDays5))
        months.append(DiaryMonth(month: "Jun",diaryDays:diaryDays6))
        months.append(DiaryMonth(month: "Jul",diaryDays:diaryDays7))
        months.append(DiaryMonth(month: "Aug",diaryDays:diaryDays8))
        months.append(DiaryMonth(month: "Sep",diaryDays:diaryDays9))
        months.append(DiaryMonth(month: "Oct",diaryDays:diaryDays10))
        months.append(DiaryMonth(month: "Nov",diaryDays:diaryDays11))
        months.append(DiaryMonth(month: "Dec",diaryDays:diaryDays12))
        
        currMonth = getCurMonth() - 1
        currDay = months[currMonth].diaryDays.count
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tv.indexPathForSelectedRow{
            self.tv.deselectRow(at: index, animated: true)
        }
    }
    

    
    func initView() -> Void {
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addDiary))
        
        self.navigationItem.rightBarButtonItem = addButton
        
        
        let headerHeight: CGFloat = 40;
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tv = UITableView(frame: CGRect(x: 0, y: barHeight + headerHeight + navigationBarHeight, width: displayWidth, height: displayHeight - barHeight - headerHeight))
        
        //tv.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tv.dataSource = self
        tv.delegate = self
        tv.register(DiaryCellVC.self, forCellReuseIdentifier: identifier)
        
        let cellHeigth: CGFloat = 130;
        tv.rowHeight = cellHeigth
        
        
        
        
        header = DiaryMonthHeaderView(frame: CGRect(x: 0, y: navigationBarHeight+barHeight, width: self.view.frame.size.width, height: 40))
        header.backgroundColor      = UIColor.white
        header.layer.borderWidth    = 1.0
        header.layer.borderColor    = UIColor.lightText.cgColor
        header.lblMonth.text        = "\(currYear) \(months[currMonth].month)"
        
        header.left.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.currMonth -= 1
            
            if (self.currMonth < 0)
            {
                self.currYear -= 1
                self.currMonth = 11
            }
            self.header.lblMonth.text = "\(self.currYear) \(self.months[self.currMonth].month)"
            self.currDay = self.months[self.currMonth].diaryDays.count
            
            self.tv.reloadData()
            
        }
        
        header.right.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.currMonth += 1
           
            
            if (self.currMonth > 11)
            {
                self.currYear += 1
                self.currMonth = 0
                
            }
            self.header.lblMonth.text = "\(self.currYear) \(self.months[self.currMonth].month)"
            self.currDay = self.months[self.currMonth].diaryDays.count
            
            self.tv.reloadData()
            
        }
        
        self.view.addSubview(header)
        self.view.addSubview(tv)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currDay
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DiaryCellVC
        
        months[self.currMonth].diaryDays.sort(by: {$0.date < $1.date})//sort

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: months[self.currMonth].diaryDays[indexPath.row].date)
        cell.lblDate.text = "\(date)"
        cell.lblWeek.text = "\(months[self.currMonth].diaryDays[indexPath.row].week)"
        cell.lblWeather.text = "\(months[self.currMonth].diaryDays[indexPath.row].weather)"
        
        let image = months[self.currMonth].diaryDays[indexPath.row].image
        let crImage = processImageToCell(image: image!)
        cell.backgroundView = UIImageView(image: crImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = DiaryDetailVC()
        detailsVC._diary = months[currMonth].diaryDays[indexPath.row]
        

        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func processImageToCell(image: UIImage) -> UIImage {
        let scaleWidth = self.view.frame.size.width/image.size.width;
        let scaleHeight = self.view.frame.size.width/image.size.height;
        
        let reSize = CGSize(width: image.size.width*scaleWidth/2, height: image.size.height*scaleHeight/2)
        let reImage = image.reSizeImage(reSize:reSize)
        
        return cropImage(image: reImage, width: self.view.frame.size.width, height: 130)
    }
    
    func cropImage(image:UIImage,width:CGFloat,height:CGFloat) -> UIImage {
        let cgI = image.cgImage
        
        return UIImage(cgImage: (cgI?.cropping(to: CGRect(x: 0, y: image.size.height - 130/2, width: width, height: height)))!)
    }
}

extension DiaryVC: DataEnterDelegate {
    func diaryEnter(diary: Diary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let inputMonth = dateFormatter.string(from: diary.date)
        
        addDiaryArray(diary:diary,month:(inputMonth as NSString).integerValue)
    }
    
    func addDiaryArray(diary: Diary,month: Int)-> Void{
        months[month-1].diaryDays.append(diary)
        currDay = months[currMonth].diaryDays.count
        self.tv.reloadData()
        
    }
}

extension UIImage {
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x:0, y:0, width:reSize.width, height:reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width:self.size.width * scaleSize, height:self.size.height * scaleSize)
        return reSizeImage(reSize:reSize)
    }
}

