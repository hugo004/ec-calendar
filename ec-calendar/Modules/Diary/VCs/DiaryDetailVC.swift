//
//  DiaryDetailVC.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 21/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class DiaryDetailVC: UIViewController {
    
    var contentHeaderView : DiaryDetailView!
    
    var year : Int = 0
    var month : Int = 0
    var index : Int = 0
    
    let imageView = UIImageView.init()
    let imagetitle = UILabel.init()
    let scrollView = UIScrollView.init()
    let contentView = UILabel.init()
    
    var _diary : Diary!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func editDiary()
    {
        let editVC = EditDiaryVC()
        editVC.finishDelegate = self
        
        editVC._diary = _diary
        editVC.year = self.year
        editVC.month = self.month
        editVC.index = self.index
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    
    
    func initView() -> Void {
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(editDiary))
        self.navigationItem.rightBarButtonItem = editButton
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
        imageView.image = UIImage(data: _diary.image)?.alpha(0.7)
        
        
        
        imagetitle.frame = CGRect(x: 20, y: imageView.frame.size.height - 50, width: self.view.frame.size.width, height: 50)
        imagetitle.text = _diary.title
        imagetitle.font = .systemFont(ofSize: 40, weight: .bold)
        
        contentHeaderView = DiaryDetailView(frame: CGRect(x: 0, y: imageView.frame.height, width: self.view.frame.size.width, height: 50))
        contentHeaderView.backgroundColor = UIColor.lightGray
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        contentHeaderView.lblDate.text = _diary.toString()
        contentHeaderView.lblWeather.text = _diary.weather
       
        
        //contentView.backgroundColor = UIColor.black
        contentView.textColor = UIColor.black
        contentView.numberOfLines = 0
        contentView.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentView.font = UIFont.systemFont(ofSize: 20.0)
        
        contentView.text = _diary.content
        contentView.frame = CGRect(x: 20, y: imageView.frame.height+contentHeaderView.frame.height+20, width: self.view.frame.size.width-40, height: contentView.font.pointSize*contentView.font.lineHeight-40)
        contentView.sizeToFit()
        
        
        
        /*print(contentView.font.pointSize)
        print(contentView.font.lineHeight)
        print(contentView.frame.height)*/
        
        
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: imageView.frame.height+contentHeaderView.frame.height+contentView.frame.height)
        imageView.addSubview(imagetitle)
        scrollView.addSubview(imageView)
        scrollView.addSubview(contentHeaderView)
        scrollView.addSubview(contentView)
        
        
        
        //imageView = DiaryDetailImageView(frame: CGRect(x: 0, y: navigationBarHeight+barHeight, width: self.view.frame.size.width, height: 300))
        //imageView.imageView.image = #imageLiteral(resourceName: "test")
        
        self.view.addSubview(scrollView)
        
        
        
    }
    
}

extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension DiaryDetailVC: FinishEdit {
    func diaryEdit(diary: Diary) {
        _diary = diary
        initView()
        updateDateArray(diary: _diary)
    }
    
    func updateDateArray(diary: Diary) {
        var daysArray = Helper.localRetrieveDiary(key: "\(year)-\(month)")
        daysArray[index] = diary
        Helper.localSaveDiary(data: daysArray, key: "\(year)-\(month)")
        
    }
    
}
