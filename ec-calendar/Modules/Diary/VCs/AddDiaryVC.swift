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
    
    var newMedia: Bool?
    let imgPicture = UIImageView.init()
    let txtContent = UITextView.init()
    let txtWeather = UITextField.init()
    let txtTitle = UITextField.init()
    let datePicker = UIDatePicker.init()
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(Submit))
        self.navigationItem.rightBarButtonItem = saveButton
        saveButton.isEnabled = false
        
        
        imagePicker.delegate = self
        
        //  UserDefaults.standard.set("chinese",forKey:"language")
        
        
        lblImage.frame = CGRect(x: 9, y: 120, width: 70, height: 21)
        lblImage.text = "Image:"
        
        lblTitle.frame = CGRect(x: 9, y: 180, width: 70, height: 21)
        lblTitle.text = "Title:"
        
        
        
        lblWeather.frame = CGRect(x: 9, y: 240, width: 70, height: 21)
        lblWeather.text = "Weather:"
        
        
        
        lblDate.frame = CGRect(x: 9, y: 300, width: 70, height: 21)
        lblDate.text = "Date:"
        
        
        
        lblContent.frame = CGRect(x: 9, y: 360, width: 70, height: 21)
        lblContent.text = "Content:"
        
        
        
        imgPicture.image = UIImage(named:"timg.jpg")!
        imgPicture.backgroundColor = UIColor.lightGray
        imgPicture.frame = CGRect(x: UIScreen.main.bounds.width-100, y: 95, width: 70, height: 70)
        
        
        
        
        txtTitle.frame = CGRect(x: UIScreen.main.bounds.width-198, y: 175, width: 168, height: 30)
        txtTitle.layer.borderColor = UIColor.black.cgColor
        txtTitle.layer.borderWidth = 1
        txtTitle.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        
        
        txtWeather.frame = CGRect(x: UIScreen.main.bounds.width-198, y: 231, width: 168, height: 30)
        txtWeather.layer.borderColor = UIColor.black.cgColor
        txtWeather.layer.borderWidth = 1
        txtWeather.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        
        datePicker.frame = CGRect(x: UIScreen.main.bounds.width-277, y: 288, width: 249, height: 46)
        datePicker.datePickerMode = .date
        
        
        
        
        txtContent.frame = CGRect(x: 9, y: 400, width: UIScreen.main.bounds.width-30, height: 400)
        txtContent.layer.borderColor = UIColor.black.cgColor
        txtContent.layer.borderWidth = 1
        txtContent.delegate = self
        
        
        btnCamera.frame = CGRect(x: UIScreen.main.bounds.width-190, y: 120, width: 70, height: 30)
        
        btnCamera.backgroundColor = UIColor.lightGray
        btnCamera.setTitle("Camera", for: UIControl.State.normal)
        btnCamera.tintColor = UIColor.black
        btnCamera.addTarget(self, action: #selector(AddDiaryVC.Camareause(_:)), for: .touchUpInside)
        
        
        
        
        
        
        
        btnGallery.frame = CGRect(x: UIScreen.main.bounds.width-270, y: 120, width: 70, height: 30)
        
        btnGallery.backgroundColor = UIColor.lightGray
        btnGallery.setTitle("Gallery", for: UIControl.State.normal)
        btnGallery.tintColor = UIColor.black
        btnGallery.addTarget(self, action: #selector(AddDiaryVC.Galleryuse(_:)), for: .touchUpInside)
        
        ChangeLan()
        
    
        
        
        self.view.addSubview(lblImage)
        self.view.addSubview(lblTitle)
        self.view.addSubview(lblWeather)
        self.view.addSubview(lblDate)
        self.view.addSubview(lblContent)
        self.view.addSubview(imgPicture)
        self.view.addSubview(txtTitle)
        self.view.addSubview(txtWeather)
        self.view.addSubview(datePicker)
        self.view.addSubview(txtContent)
        //self.view.addSubview(btnSubmit)
        self.view.addSubview(btnCamera)
        self.view.addSubview(btnGallery)
        
        
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
        let imageData:NSData = imagesave.pngData()! as NSData
        let imageBase64String = imageData.base64EncodedString()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let day = Diary(date: datePicker.date, week: "123", weather: txtWeather.text!, content: txtContent.text!, title: txtTitle.text!, image: imagesave)
        
        delegate.diaryEnter(diary: day)
        Helper.localSaveDiary(data: [day], key: "myDiary")
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
        
        
        //add user default
        //UserDefaults.standard.set(txtContent.text, forKey: "")
        //UserDefaults.standard.set(txtWeather.text, forKey: "")
        //UserDefaults.standard.set(txtTitle.text, forKey: "")
        //UserDefaults.standard.set(dateFormatter.string(from: datePicker.date), forKey: "")
        //UserDefaults.standard.set(imageBase64String, forKey: "")
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
    
    public func ChangeLan(){
        
        if let lan = UserDefaults.standard.object(forKey: "language"){
            if let path = Bundle.main.path(forResource: lan as! String, ofType: "plist") {
                let dictRoot = NSDictionary(contentsOfFile: path)
                if let dict = dictRoot {
                    lblImage.text = dict["DiaryAddlblImage"] as! String
                    lblTitle.text = dict["DiaryAddlblTitle"] as! String
                    lblWeather.text = dict["DiaryAddlblWeather"] as! String
                    lblContent.text = dict["DiaryAddlblContent"] as! String
                    lblDate.text  = dict["DiaryAddlblDate"] as! String
                    btnSubmit.setTitle(dict["DiaryAddbtnSubmit"] as! String, for: UIControl.State.normal)
                    btnCamera.setTitle(dict["DiaryAddbtnCamera"] as! String, for: UIControl.State.normal)
                    
                    btnGallery.setTitle(dict["DiaryAddbtnGallery"] as! String, for: UIControl.State.normal)
                    
                }
            }
        }
    }
    
    
    
}

