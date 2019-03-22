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

class EditDiaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var _diary : Diary!
    var year : Int = 0
    var month : Int = 0
    var index : Int = 0
    
    var finishDelegate:FinishEdit!
    
    var tv : UITableView!
    let scrollView = UIScrollView.init()
    let imageView = UIImageView.init()
    let imagetitle = UILabel.init()
    let txtContent = UITextView.init()
    var saveButton = UIBarButtonItem.init()
    let datePicker = UIDatePicker.init()
    
    var newDatePicker : DiaryPickDateView!
    
    let btnDelete = UIButton.init()
    let imagePicker = UIImagePickerController()
    
    var table0 = ["Image"]
    var table1 = ["Title","Weather"]
    var table2 = ["Date"]
    var table3 = ["Content"]
    var table4 = ["Delete"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()
        

        // Do any additional setup after loading the view.
    }
    
    @objc func SaveEdit(_ sender:UIButton!)
    {
        let titleIndexPath = IndexPath(row: 0, section: 1)
        let titleCell = tv.cellForRow(at: titleIndexPath) as! EditandAddView
        
        let y = newDatePicker.rightYearViewData[newDatePicker.rightYear.selectedRow(inComponent: 0)]
        let m = newDatePicker.centerMonthViewData[newDatePicker.centerMonth.selectedRow(inComponent: 0)]
        let d = newDatePicker.leftDayViewData[newDatePicker.leftDay.selectedRow(inComponent: 0)]
        
        var daysArray = Helper.localRetrieveDiary(key: "\(y)-\(m)")
        var isExist = false
        daysArray.forEach {
            (diary) in
            if diary.day == d {
                isExist = true
            }
        }
        
        if (isExist && m != month) {
            let alert = UIAlertController(title: Helper.Localized(key: "diary_edit_alert_warming_title"), message: Helper.Localized(key: "diary_edit_alert_warming_message"), preferredStyle: .alert)
            let action = UIAlertAction(title: "OK!", style: .default) {
                (UIAlertAction) in self
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else if !isExist && m != month{
            var daysArray = Helper.localRetrieveDiary(key: "\(year)-\(month)")
            
            for i in 0...(daysArray.count-1){
                if daysArray[i].month == month && daysArray[i].day == _diary.day{
                    daysArray.remove(at: i)
                    break
                }
            }
            Helper.localSaveDiary(data: daysArray, key: "\(year)-\(month)")
            
            let day = Diary(year: y, month: m, day: d, weather:titleCell.txtInput.text!, content: txtContent.text!, title: titleCell.txtInput.text!, image: imageView.image!)
            
            var newDaysArray = Helper.localRetrieveDiary(key: "\(y)-\(m)")
            newDaysArray.append(day)
            Helper.localSaveDiary(data: newDaysArray, key: "\(y)-\(m)")
        
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count-3], animated: true)
        } else if (isExist && m == month){
            
            let day = Diary(year: y, month: m, day: d, weather:titleCell.txtInput.text!, content: txtContent.text!, title: titleCell.txtInput.text!, image: imageView.image!)
            finishDelegate.diaryEdit(diary: day)
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
        
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
        
        imagePicker.delegate = self
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: navigationBarHeight+barHeight+tv.frame.height)
        scrollView.addSubview(tv)
        self.view.addSubview(scrollView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0: return table0.count
        case 1: return table1.count
        case 2: return table2.count
        case 3: return table3.count
        case 4: return table3.count
        default:return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return " "
        case 1: return " "
        case 2: return " "
        case 3: return " "
        case 4: return " "
        default:return " "
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0: return 0
        case 1: return 10
        case 2: return 30
        case 3: return 30
        case 4: return 30
        default:return 0
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let controller = UIAlertController(title: Helper.Localized(key: "diary_edit_alert_title"), message: "", preferredStyle: .actionSheet)
        let names = [Helper.Localized(key: "diary_edit_alert_photoBook"), Helper.Localized(key: "diary_edit_alert_camera")]
        
        let openPhoto = UIAlertAction(title: names[0], style: .default) { (action) in
            self.Galleryuse()
        }
        
        let openCamera = UIAlertAction(title: names[1], style: .default) { (action) in
            self.Camareause()
        }
        
        controller.addAction(openPhoto)
        controller.addAction(openCamera)
        let cancelAction = UIAlertAction(title: Helper.Localized(key: "diary_edit_alert_cancel"), style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleToFill
            _diary.image = image.pngData()!
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func Camareause()
    {
        
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            
            
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            /*imagePicker.mediaTypes = [kUTTypeImage as String]
             imagePicker.allowsEditing = false*/
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            //newMedia = true
        }
        
        
    }
    
    @objc func Galleryuse()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditandAddView
        
        if indexPath.section == 0 {
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            
            imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
            imageView.image = UIImage(data: _diary.image)
            
            cell.addSubview(imageView)
            cell.txtInput.isHidden = true
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
            
            newDatePicker = DiaryPickDateView(frame: CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width, height: cell.contentView.frame.size.height))
            newDatePicker.day = _diary.day
            newDatePicker.month = _diary.month
            newDatePicker.year = _diary.year
            newDatePicker.afterInit()
            cell.addSubview(newDatePicker)
            cell.selectionStyle = .none
            
        }else if indexPath.section == 3 {
            cell.txtInput.isEnabled = false
            txtContent.frame = CGRect(x: 20, y: 0, width: cell.contentView.frame.size.width-40, height: cell.contentView.frame.size.height)
            txtContent.delegate = self
            txtContent.text = _diary.content
            txtContent.font = UIFont.systemFont(ofSize: 20.0)
            
            cell.addSubview(txtContent)
            //cell.lbltitle.text = table3[indexPath.row]
            cell.selectionStyle = .none
        }else if indexPath.section == 4 {
            cell.txtInput.isEnabled = false
            btnDelete.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
            btnDelete.setTitle(Helper.Localized(key: "diary_edit_btnDelete"), for: .normal)
            btnDelete.setTitleColor(UIColor.red, for: .normal)
            btnDelete.addTarget(self, action: #selector(DeleteDiary), for: UIControl.Event.touchUpInside)
            
            cell.addSubview(btnDelete)
            //cell.lbltitle.text = table3[indexPath.row]
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    @objc func DeleteDiary() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        
        var daysArray = Helper.localRetrieveDiary(key: "\(year)-\(month)")
        
        for i in 0...(daysArray.count-1){
            if daysArray[i].month == month && daysArray[i].day == _diary.day{
                daysArray.remove(at: i)
                break
            }
        }
        
        Helper.localSaveDiary(data: daysArray, key: "\(year)-\(month)")
        self.navigationController!.popToViewController(viewControllers[viewControllers.count-3], animated: true)
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
        }else if indexPath.section == 4 {
            return 60
        }
        return 60
    }
    
    
}
