//
//  ViewController.swift
//  Project1
//
//  Created by terry on 2019/3/16.
//  Copyright © 2019 terry. All rights reserved.
//
import MobileCoreServices
import UIKit

protocol DataEnterDelegate {
    func diaryEnter(diary:Diary)
}

private let identifier  = "AddDiaryVC"

class AddDiaryVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate ,UITextViewDelegate {
    
    var delegate:DataEnterDelegate!
    let scrollView = UIScrollView.init()
    
    var newMedia: Bool?
    let imgPicture = UIImageView.init()
    let txtContent = UITextView.init()
    let txtWeather = UITextField.init()
    let txtTitle = UITextField.init()
    let datePicker = UIDatePicker.init()
    
    var newDatePicker : DiaryPickDateView!
    
    let lblImage = UILabel.init()
    let lblTitle = UILabel.init()
    let lblWeather = UILabel.init()
    let lblDate = UILabel.init()
    let lblContent = UILabel.init()
    let btnSubmit = UIButton(type: UIButton.ButtonType.system) as UIButton
    let btnCamera = UIButton(type: UIButton.ButtonType.system) as UIButton
    let btnGallery = UIButton(type: UIButton.ButtonType.system) as UIButton
    var saveButton = UIBarButtonItem.init()
    
    
    
    let imagePicker = UIImagePickerController()
    var imagesave : UIImage = UIImage(named:"timg.jpg")!
    
    var curDay : Int = 0
    var curMonth : Int = 0
    var curYear : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(Submit))
        self.navigationItem.rightBarButtonItem = saveButton
        saveButton.isEnabled = false
        
        
        imagePicker.delegate = self
        
        //  UserDefaults.standard.set("chinese",forKey:"language")
        
        
        lblImage.frame = CGRect(x: 9, y: 30, width: 70, height: 21)
        lblImage.text = Helper.Localized(key: "diary_add_lblImage");
        
        lblTitle.frame = CGRect(x: 9, y: 90, width: 70, height: 21)
        lblTitle.text = Helper.Localized(key: "diary_add_lblTitle");
        
        
        lblWeather.frame = CGRect(x: 9, y: 150, width: 70, height: 21)
        lblWeather.text = Helper.Localized(key: "diary_add_lblWeather");
        
        lblDate.frame = CGRect(x: 9, y: 210, width: 70, height: 21)
        lblDate.text = Helper.Localized(key: "diary_add_lblDate");
        
        lblContent.frame = CGRect(x: 9, y: 270, width: 70, height: 21)
        lblContent.text = Helper.Localized(key: "diary_add_lblContent");
        
        
        imgPicture.image = UIImage(named:"timg.jpg")!
        imgPicture.backgroundColor = UIColor.lightGray
        imgPicture.frame = CGRect(x: UIScreen.main.bounds.width-100, y: 10, width: 70, height: 70)
        
        
        
        
        txtTitle.frame = CGRect(x: UIScreen.main.bounds.width-198, y: 90, width: 168, height: 30)
        txtTitle.layer.borderColor = UIColor.black.cgColor
        txtTitle.layer.borderWidth = 1
        txtTitle.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        
        
        txtWeather.frame = CGRect(x: UIScreen.main.bounds.width-198, y: 150, width: 168, height: 30)
        txtWeather.layer.borderColor = UIColor.black.cgColor
        txtWeather.layer.borderWidth = 1
        txtWeather.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        
        newDatePicker = DiaryPickDateView(frame: CGRect(x: UIScreen.main.bounds.width-277, y: 210, width: 249, height: 46))
        newDatePicker.day = curDay
        newDatePicker.month = curMonth
        newDatePicker.year = curYear
        newDatePicker.afterInit()
        
        
        /*newDatePicker.frame = CGRect(x: UIScreen.main.bounds.width-277, y: 288, width: 249, height: 46)*/
        /*datePicker.frame = CGRect(x: UIScreen.main.bounds.width-277, y: 288, width: 249, height: 46)
        datePicker.datePickerMode = .date*/
        
        
        
        
        txtContent.frame = CGRect(x: 9, y: 300, width: UIScreen.main.bounds.width-30, height: 400)
        txtContent.layer.borderColor = UIColor.black.cgColor
        txtContent.layer.borderWidth = 1
        txtContent.delegate = self
        
        
        btnCamera.frame = CGRect(x: UIScreen.main.bounds.width-190, y: 30, width: 70, height: 30)
        
        btnCamera.backgroundColor = UIColor.lightGray
        btnCamera.setTitle("Camera", for: UIControl.State.normal)
        btnCamera.tintColor = UIColor.black
        btnCamera.addTarget(self, action: #selector(AddDiaryVC.Camareause(_:)), for: .touchUpInside)
        
        
        
        
        
        btnGallery.frame = CGRect(x: UIScreen.main.bounds.width-270, y: 30, width: 70, height: 30)
        
        btnGallery.backgroundColor = UIColor.lightGray
        btnGallery.setTitle("Gallery", for: UIControl.State.normal)
        btnGallery.tintColor = UIColor.black
        btnGallery.addTarget(self, action: #selector(AddDiaryVC.Galleryuse(_:)), for: .touchUpInside)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
        scrollView.addSubview(lblImage)
        scrollView.addSubview(lblTitle)
        scrollView.addSubview(lblWeather)
        scrollView.addSubview(lblDate)
        scrollView.addSubview(lblContent)
        scrollView.addSubview(imgPicture)
        scrollView.addSubview(txtTitle)
        scrollView.addSubview(txtWeather)
        scrollView.addSubview(newDatePicker)
        scrollView.addSubview(txtContent)
        scrollView.addSubview(btnCamera)
        scrollView.addSubview(btnGallery)
        
        
    
        
        
        /*self.view.addSubview(lblImage)
        self.view.addSubview(lblTitle)
        self.view.addSubview(lblWeather)
        self.view.addSubview(lblDate)
        self.view.addSubview(lblContent)
        self.view.addSubview(imgPicture)
        self.view.addSubview(txtTitle)
        self.view.addSubview(txtWeather)
        self.view.addSubview(newDatePicker)
        
        //self.view.addSubview(datePicker)
        self.view.addSubview(txtContent)
        //self.view.addSubview(btnSubmit)
        self.view.addSubview(btnCamera)
        self.view.addSubview(btnGallery)*/
        self.view.addSubview(scrollView)
        
        
    }
    
    @objc func textFieldEditingDidChange(_ text:UITextField){
        if (txtTitle.text?.trimmingCharacters(in: .whitespaces).count)! > 0 &&
            (txtWeather.text?.trimmingCharacters(in: .whitespaces).count)! > 0 &&
            (txtContent.text?.trimmingCharacters(in: .whitespaces).count)! > 0{
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
    
    func textViewDidChange(_ textView : UITextView){
        if (txtTitle.text?.trimmingCharacters(in: .whitespaces).count)! > 0 &&
            (txtWeather.text?.trimmingCharacters(in: .whitespaces).count)! > 0 &&
            (textView.text?.trimmingCharacters(in: .whitespaces).count)! > 0{
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
    
    
    
    @objc func Submit(_ sender:UIButton!)
    {
        /*let imageData:NSData = imagesave.pngData()! as NSData
        let imageBase64String = imageData.base64EncodedString()*/
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let y = newDatePicker.rightYearViewData[newDatePicker.rightYear.selectedRow(inComponent: 0)]
        let m = newDatePicker.centerMonthViewData[newDatePicker.centerMonth.selectedRow(inComponent: 0)]
        let d = newDatePicker.leftDayViewData[newDatePicker.leftDay.selectedRow(inComponent: 0)]
        
        let daysArray = Helper.localRetrieveDiary(key: "\(y)-\(m)")
        
        var isExist = false
        daysArray.forEach {
            (diary) in
            if diary.day == d {
                isExist = true
            }
        }
        if isExist{
            let alert = UIAlertController(title: Helper.Localized(key: "diary_add_alert_title"), message: Helper.Localized(key: "diary_add_alert_message"), preferredStyle: .alert)
            let action = UIAlertAction(title: "OK!", style: .default) {
                (UIAlertAction) in self
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else{
            let day = Diary(year: y, month: m, day: d, weather: txtWeather.text!, content: txtContent.text!, title: txtTitle.text!, image: imagesave)
             delegate.diaryEnter(diary: day)
             self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func Camareause(_ sender:UIButton!)
    {
        
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            
            
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgPicture.contentMode = .scaleToFill
            imagesave = image;
            imgPicture.image=image
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    @objc func Galleryuse(_ sender:UIButton!)
    {
        
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

