//
//  LanguageVC.swift
//  CheckListReminder
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

struct Language {
    var name: String
    var code: String
}

class LanguageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var tableView: UITableView!
    
    var items: [Language] = {
        var datas: [Language] = []
            datas.append(Language(name: Helper.Localized(key: "language_chinese"), code: "zh-HK"))
            datas.append(Language(name: Helper.Localized(key: "language_english"), code: "en"))
        
        return datas
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView                   = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.rowHeight         = UITableView.automaticDimension
        tableView.separatorStyle    = .singleLine
        
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier              = "cell"
        var cell                    = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil
        {
            cell                    = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.selectionStyle    = .none
        }
        
        cell?.textLabel?.text = items[indexPath.row].name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Helper.changeLanguage(code: items[indexPath.row].code);
        self.navigationController?.setViewControllers([HomeVC()], animated: true); //reload
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SwitchLanguage"), object: nil, userInfo: nil);
        
        

    }
    
}
