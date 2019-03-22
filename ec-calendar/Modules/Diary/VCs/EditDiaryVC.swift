//
//  EditDiaryVC.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 21/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

private let identifier  = "Cell"

protocol FinishEdit {
    func diaryEdit(diary:Diary)
}

class EditDiaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextViewDelegate {
    
    var _diary : Diary!
    
    var finishDelegate:FinishEdit!
    
    var tv : UITableView!
    let scrollView = UIScrollView.init()
    let imageView = UIImageView.init()
    let imagetitle = UILabel.init()
    let txtContent = UITextView.init()
    var saveButton = UIBarButtonItem.init()
    let datePicker = UIDatePicker.init()
    
    var table0 = ["Image"]
    var table1 = ["Title","Weather"]
    var table2 = ["Date"]
    var table3 = ["Content"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()

        // Do any additional setup after loading the view.
    }
    
    @objc func SaveEdit(_ sender:UIButton!)
    {
        
        let indexPath = IndexPath(row: 1, section: 1)
        let weathercell = tv.cellForRow(at: indexPath) as! EditandAddView
        
        let titleIndexPath = IndexPath(row: 0, section: 1)
        let titleCell = tv.cellForRow(at: titleIndexPath) as! EditandAddView
        
        let day = Diary(date: datePicker.date, week: "123", weather: weathercell.txtInput.text!, content: txtContent.text!, title: titleCell.txtInput.text!, image: imageView.image!)

        finishDelegate.diaryEdit(diary: day)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func initView() -> Void {
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(SaveEdit))
        self.navigationItem.rightBarButtonItem = saveButton
        
        tv = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight))
        
        tv.register(EditandAddView.self, forCellReuseIdentifier: identifier)
        tv.dataSource = self
        tv.delegate = self
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: navigationBarHeight+barHeight+tv.frame.height)
        scrollView.addSubview(tv)
        self.view.addSubview(scrollView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0: return table0.count
        case 1: return table1.count
        case 2: return table2.count
        case 3: return table3.count
        default:return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return " "
        case 1: return " "
        case 2: return " "
        case 3: return " "
        default:return " "
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0: return 0
        case 1: return 10
        case 2: return 30
        case 3: return 30
        default:return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditandAddView
        
        if indexPath.section == 0 {
            //let image = UIImage(named: "test")
            imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
            imageView.image = UIImage(data: _diary.image)
            cell.addSubview(imageView)
            cell.txtInput.isEnabled = false
        }else if indexPath.section == 1 {
            //cell.lbltitle.text = table1[indexPath.row]
            cell.selectionStyle = .none
            cell.txtInput.placeholder = table1[indexPath.row]
            if indexPath.row == 1{
                cell.txtInput.text = _diary.weather
            }else{
                cell.txtInput.text = _diary.title
            }
        }else if indexPath.section == 2 {
            
            
            datePicker.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width, height: cell.contentView.frame.size.height)
            datePicker.datePickerMode = .date
            datePicker.date = _diary.date
            
            cell.txtInput.isEnabled = false
            cell.addSubview(datePicker)
            //cell.lbltitle.text = table2[indexPath.row]
            cell.selectionStyle = .none
            
        }else if indexPath.section == 3 {
            cell.txtInput.isEnabled = false
            txtContent.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width, height: 400)
            txtContent.layer.borderColor = UIColor.black.cgColor
            txtContent.layer.borderWidth = 1
            txtContent.delegate = self
            txtContent.text = _diary.content
            
            cell.addSubview(txtContent)
            //cell.lbltitle.text = table3[indexPath.row]
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }else if indexPath.section == 1 {
            return 60
        }else if indexPath.section == 2 {
            return 60
        }else if indexPath.section == 3 {
            return 300
        }
        return 60
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
