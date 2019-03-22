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
    var monthDaysArray: [Diary] = []
    
    var currYear = 0
    var currMonth   = 0
    var currDay     = 0
    var existDays = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initDiaryDataSource()
        initView()
        

        // Do any additional setup after loading the view.
    }
    
    func getCurYear() -> Int{
        let currentDate = Date()
        let curDateForrmat = DateFormatter()
        curDateForrmat.dateFormat = "YYYY"
        
        return (curDateForrmat.string(from: currentDate) as NSString).integerValue
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let date = Date()
        addDiaryVC.curDay = (dateFormatter.string(from: date) as NSString).integerValue
        addDiaryVC.curMonth = getCurMonth()
        addDiaryVC.curYear = getCurYear()
        
        self.navigationController?.pushViewController(addDiaryVC, animated: true)
    }
    
    func initDiaryDataSource() -> Void {
        
        currYear = getCurYear()
        currMonth = getCurMonth()
        
        monthDaysArray =  Helper.localRetrieveDiary(key: "\(currYear)-\(currMonth)")
        
        /*monthDaysArray.removeAll()
        Helper.localSaveDiary(data: monthDaysArray, key: "\(currYear)-\(currMonth)")
        
        var test =  Helper.localRetrieveDiary(key: "\(currYear)-\(currMonth+1)")
        
        test.removeAll()
        Helper.localSaveDiary(data: test, key: "\(currYear)-\(currMonth+1)")*/
        
        
        if !monthDaysArray.isEmpty {
            existDays = monthDaysArray.count
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tv.indexPathForSelectedRow{
            self.tv.deselectRow(at: index, animated: true)
        }
        monthDaysArray =  Helper.localRetrieveDiary(key: "\(currYear)-\(currMonth)")
        if !monthDaysArray.isEmpty {
            existDays = monthDaysArray.count
        }
        self.tv.reloadData()
    }
    

    
    func initView() -> Void {
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addDiary))
        self.navigationItem.rightBarButtonItem = addButton
        
        let headerHeight: CGFloat = 40;
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tv = UITableView(frame: CGRect(x: 0, y: barHeight+headerHeight , width: displayWidth, height: displayHeight - barHeight - headerHeight))
        
        //tv.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tv.dataSource = self
        tv.delegate = self
        tv.register(DiaryCellVC.self, forCellReuseIdentifier: identifier)
        
        let cellHeigth: CGFloat = 130;
        tv.rowHeight = cellHeigth
        
        

        header = DiaryMonthHeaderView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.size.width, height: 40))
        header.backgroundColor      = UIColor.white
        header.layer.borderWidth    = 1.0
        header.layer.borderColor    = UIColor.lightText.cgColor
        header.lblMonth.text        = "\(currYear)/\(currMonth)"
        
        header.left.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.currMonth -= 1
            
            if (self.currMonth < 1)
            {
                self.currYear -= 1
                self.currMonth = 12
            }
            self.header.lblMonth.text = "\(self.currYear)/\(self.currMonth)"
            self.monthDaysArray = Helper.localRetrieveDiary(key: "\(self.currYear)-\(self.currMonth)")
            self.currDay = self.monthDaysArray.count

            
            self.tv.reloadData()
            
        }
        
        header.right.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.currMonth += 1
           
            
            if (self.currMonth > 12)
            {
                self.currYear += 1
                self.currMonth = 1
                
            }
            self.header.lblMonth.text = "\(self.currYear)/\(self.currMonth)"
            self.monthDaysArray = Helper.localRetrieveDiary(key: "\(self.currYear)-\(self.currMonth)")
            self.currDay = self.monthDaysArray.count
            self.tv.reloadData()
            
        }
        
        self.view.addSubview(header)
        self.view.addSubview(tv)
        
        
        let btnAdd = UIButton();
        btnAdd.setBackgroundImage(UIImage(named: "btn-plus"), for: .normal);
        self.view.addSubview(btnAdd);
        
        btnAdd.reactive.controlEvents(.touchUpInside).observeValues { _ in
            self.addDiary();
        }
        
        btnAdd.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20);
        }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.monthDaysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DiaryCellVC
        
        self.monthDaysArray.sort(by: {$0.day < $1.day})//sort

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = self.monthDaysArray[indexPath.row].toString()
        cell.lblDate.text = date
        cell.lblWeather.text = "\(self.monthDaysArray[indexPath.row].weather)"
        
        let image = self.monthDaysArray[indexPath.row].image
        let crImage = processImageToCell(image: UIImage(data: image)!)
        cell.backgroundView = UIImageView(image: crImage)
        cell.backgroundView?.alpha = 0.5
 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = DiaryDetailVC()
        detailsVC._diary = self.monthDaysArray[indexPath.row]
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month = monthDaysArray[indexPath.row].getMonth()
        
        detailsVC.year = currYear
        detailsVC.month = month
        detailsVC.index = indexPath.row
        
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
        let inputMonth = diary.getMonth()
        
        addDiaryArray(diary:diary,month:inputMonth)
    }
    
    func addDiaryArray(diary: Diary,month: Int)-> Void{
        var daysArray = Helper.localRetrieveDiary(key: "\(diary.year)-\(diary.month)")
        daysArray.append(diary)
        //print("\(currYear)-\(currMonth)")
        
        Helper.localSaveDiary(data: daysArray, key: "\(diary.year)-\(diary.month)")
        //print("\(currYear)-\(currMonth)")
        
        currDay = monthDaysArray.count
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

