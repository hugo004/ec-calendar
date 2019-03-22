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
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    
    
    func initView() -> Void {
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(editDiary))
        self.navigationItem.rightBarButtonItem = editButton
        
        
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        scrollView.frame = CGRect(x: 0, y: navigationBarHeight+barHeight, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
        imageView.image = UIImage(data: _diary.image)        //imageView.backgroundColor = UIColor.blue
        
        imagetitle.frame = CGRect(x: 0, y: imageView.frame.size.height - 50, width: self.view.frame.size.width, height: 50)
        imagetitle.text = _diary.title
        imagetitle.font = UIFont(name: "OldSansBlack", size: 50)
        
        contentHeaderView = DiaryDetailView(frame: CGRect(x: 0, y: imageView.frame.height, width: self.view.frame.size.width, height: 80))
        contentHeaderView.backgroundColor = UIColor.lightGray
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        contentHeaderView.lblDate.text = dateFormatter.string(from: _diary.date)
        contentHeaderView.lblWeather.text = _diary.weather
        contentHeaderView.lblWeek.text = _diary.week
        
        
        //contentView.backgroundColor = UIColor.black
        contentView.textColor = UIColor.black
        contentView.numberOfLines = 0
        contentView.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentView.font = UIFont.systemFont(ofSize: 20.0)
        
        contentView.text = _diary.content
        contentView.frame = CGRect(x: 0, y: imageView.frame.height+contentHeaderView.frame.height, width: self.view.frame.size.width, height: contentView.font.pointSize*contentView.font.lineHeight)
        contentView.sizeToFit()
        
        
        
        /*print(contentView.font.pointSize)
        print(contentView.font.lineHeight)
        print(contentView.frame.height)*/
        
        
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: navigationBarHeight+barHeight+imageView.frame.height+contentHeaderView.frame.height+contentView.frame.height)
        imageView.addSubview(imagetitle)
        scrollView.addSubview(imageView)
        scrollView.addSubview(contentHeaderView)
        scrollView.addSubview(contentView)
        
        
        
        //imageView = DiaryDetailImageView(frame: CGRect(x: 0, y: navigationBarHeight+barHeight, width: self.view.frame.size.width, height: 300))
        //imageView.imageView.image = #imageLiteral(resourceName: "test")
        
        self.view.addSubview(scrollView)
        
        
        
    }
    
}

extension DiaryDetailVC: FinishEdit {
    func diaryEdit(diary: Diary) {
        _diary = diary
        initView()
        updateDateArray(diary: _diary)
    }
    
    func updateDateArray(diary: Diary) {
        let monthDateFormatter = DateFormatter()
        monthDateFormatter.dateFormat = "MM"
        let inputMonth = monthDateFormatter.string(from: diary.date)
        
        let dayDateFormatter = DateFormatter()
        dayDateFormatter.dateFormat = "dd"
        let inputDay = dayDateFormatter.string(from: diary.date)
        
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
}
