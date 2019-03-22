//
//  Trans.swift
//  Project1
//
//  Created by terry on 2019/3/17.
//  Copyright © 2019 terry. All rights reserved.
//

import MobileCoreServices
import UIKit


class SettingVC: UIViewController {
 

    let lblLanguage = UILabel.init()

    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
      
        lblLanguage.frame = CGRect(x: 30, y: 230, width: 81, height: 21)
        lblLanguage.text = "Language:"
        
        
        
        let btnCh = UIButton(type: UIButton.ButtonType.system) as UIButton
        btnCh.frame = CGRect(x:UIScreen.main.bounds.width-100, y:225, width:80, height:30)
        
        btnCh.backgroundColor = UIColor.lightGray
        btnCh.setTitle("中文", for: UIControl.State.normal)
        btnCh.tintColor = UIColor.black
        btnCh.addTarget(self, action: #selector(SettingVC.chinese(_:)), for: .touchUpInside)
        
        
        
        
        let btnEng = UIButton(type: UIButton.ButtonType.system) as UIButton
        btnEng.frame = CGRect(x: UIScreen.main.bounds.width-250, y: 225, width: 80, height: 30)
        
        btnEng.backgroundColor = UIColor.lightGray
        btnEng.setTitle("English", for: UIControl.State.normal)
        btnEng.tintColor = UIColor.black
        btnEng.addTarget(self, action: #selector(SettingVC.english(_:)), for: .touchUpInside)
   
     
        
        self.view.addSubview(lblLanguage)
        self.view.addSubview(btnCh)
        self.view.addSubview(btnEng)
    
        
    }
    @objc func chinese(_ sender:UIButton!)
    {

       UserDefaults.standard.set("chinese", forKey: "language")
       changeAllSw()
    }
    @objc func english(_ sender:UIButton!)
    {
        
        
        UserDefaults.standard.set("english", forKey: "language")
        changeAllSw()
    }
    func changeAllSw(){
        //Call all swift file
      // DiaryAdd().ChangeLan()
       ChangeLan()
        
    }
    func ChangeLan(){// Add this one to all swift file and execute it in viewDidLoad() last
        if let lan = UserDefaults.standard.object(forKey: "language"){
         if let path = Bundle.main.path(forResource: lan as! String, ofType: "plist") {
         let dictRoot = NSDictionary(contentsOfFile: path)
         if let dict = dictRoot {
         lblLanguage.text = dict["TranslblLanguage"] as! String
       
            }
         }
         }
        
    }
  
    
    
    
    }
    
 

