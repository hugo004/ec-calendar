//
//  SettingVC.swift
//  CheckListReminder
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

struct DataSource {
    var name: String
}

enum Rows: Int {
    case Language = 0
    case Permission = 1
    case AboutApp = 2
    case CalendarMode = 3
}

class SettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    var items: [DataSource] = {
        var datas: [DataSource] = []
        datas.append(DataSource(name: Helper.Localized(key: "setting_language")))
        datas.append(DataSource(name: Helper.Localized(key: "setting_permission")))
        datas.append(DataSource(name: Helper.Localized(key: "setting_aboutapp")))
        
        if (Helper.isDoubleSundayMode())
        {
            datas.append(DataSource(name: Helper.Localized(key: "calendar_doubleSat")))
        }
        else
        {
            datas.append(DataSource(name: Helper.Localized(key: "calendar_doubleSun")))
        }
        
        return datas
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView                   = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.rowHeight         = UITableView.automaticDimension
        tableView.separatorStyle    = .singleLine
        
        self.view.addSubview(tableView);
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;

        
        // Do any additional setup after loading the view.
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
            cell?.accessoryType = .disclosureIndicator
        }
        
        cell?.textLabel?.text       = items[indexPath.row].name
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case Rows.Language.rawValue:
            self.navigationController?.pushViewController(LanguageVC(), animated: true)
            break;
        case Rows.Permission.rawValue:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            break
        case Rows.AboutApp.rawValue:
            self.navigationController?.pushViewController(AboutAppVC(), animated: true)
            break
        case Rows.CalendarMode.rawValue:
            Helper.changeCalendarMode();
            self.navigationController?.setViewControllers([HomeVC()], animated: true);
            break;
        default:
            break
        }
    }
    
}
