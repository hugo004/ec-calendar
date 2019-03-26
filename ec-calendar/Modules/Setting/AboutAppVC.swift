//
//  AboutAppVC.swift
//  CheckListReminder
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class AboutAppVC: UIViewController {
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true
        
        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        let lblIntro = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 700 ))
        let lbl = UILabel(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: 20));
        lbl.text = Helper.Localized(key: "EC_Calendar");
        lbl.backgroundColor = UIColor.white
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        //        lbl.textAlignment = .center
        scrollView.addSubview(lbl)
        lbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        lbl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true
        
        lblIntro.text = Helper.Localized(key: "ec_intro");
        lblIntro.backgroundColor = UIColor.white
        lblIntro.lineBreakMode = .byWordWrapping
        lblIntro.numberOfLines = 0
        //        lblIntro.textAlignment = .center
        scrollView.addSubview(lblIntro)
        
        // constrain labelTwo at 400-pts from the left
        lblIntro.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 400.0).isActive = true
        
        // constrain labelTwo at 1000-pts from the top
        lblIntro.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
        
        // constrain labelTwo to right & bottom with 16-pts padding
        lblIntro.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16.0).isActive = true
        lblIntro.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = Helper.Localized(key: "setting_aboutapp");
        
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
