//
//  HomeVC.swift
//  ec-calendar
//
//  Created by Hugo on 22/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class HomeVC: UITabBarController {
    
    let calendar: CalendarVC = {
        let vc = CalendarVC()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "home_calendar"), image: UIImage(named:"icon-calendar-blue"), tag: 0)
        
        return vc
    }()
    
    let setting: SettingVC = {
        let vc = SettingVC()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "home_setting") , image: UIImage(named:"icon-settings-white"), tag: 1)
        
        return vc
    }()
    
    var diary: UIViewController = {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: Helper.Localized(key: "home_diary"), image: UIImage(named:"icon-document"), tag: 1)

        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = [];
//        self.extendedLayoutIncludesOpaqueBars = true;
        
        self.viewControllers = [calendar, diary, setting];
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white;
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
    }
}
