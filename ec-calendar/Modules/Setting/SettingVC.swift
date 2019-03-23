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
    var value: String
    
    init(name: String)
    {
        self.name = name;
        self.value = "";
    }
    
    init (name: String, value: String)
    {
        self.name = name;
        self.value = value;
    }
}

enum Rows: Int {
    case Permission = 0
    case AboutApp = 1
}

enum Sections: Int {
    case General = 0
    case Language = 1
    case CalendarMode = 2
}


class SettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    var general: [DataSource] = {
        var datas: [DataSource] = []
        datas.append(DataSource(name: Helper.Localized(key: "setting_permission")))
        datas.append(DataSource(name: Helper.Localized(key: "setting_aboutapp")))
        
        return datas;
    }()
    
    var langauges: [Language] = {
        var datas: [Language] = []
        
        datas.append(Language(name: Helper.Localized(key: "language_chinese"), code:"zh-HK"))
        datas.append(Language(name: Helper.Localized(key: "language_english"), code: "en"))
        
        return datas
    }()
    
    var calendarModes: [DataSource] = {
        var datas: [DataSource] = []
        
        if Helper.isDoubleSundayMode()
        {
            datas.append(DataSource(name: Helper.Localized(key: "calendar_doubleSat"), value: "sat"))

        }
        else
        {
            datas.append(DataSource(name: Helper.Localized(key: "calendar_doubleSun"), value: "sun"))
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.General.rawValue:
            return general.count;
        case Sections.Language.rawValue:
            return langauges.count;
        case Sections.CalendarMode.rawValue:
            return calendarModes.count;
        default:
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.Language.rawValue:
            return Helper.Localized(key: "setting_language");
        case Sections.CalendarMode.rawValue:
            let mode = Helper.isDoubleSundayMode()
                ? Helper.Localized(key: "calendar_doubleSun")
                : Helper.Localized(key: "calendar_doubleSat");
            
            return "\(Helper.Localized(key: "calendar_mode")) (\(mode))"
        default:
            return "";
        }
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
        
        if indexPath.section == Sections.General.rawValue
        {
            cell?.textLabel?.text       = general[indexPath.row].name
        }
        else if indexPath.section == Sections.Language.rawValue
        {
            cell?.textLabel?.text       = langauges[indexPath.row].name
            if Helper.currentLanguage() == langauges[indexPath.row].code
            {
                cell?.accessoryType = .checkmark;
            }
            else
            {
                cell?.accessoryType = .none;
            }
        }
        else if indexPath.section == Sections.CalendarMode.rawValue
        {
            cell?.textLabel?.text       = calendarModes[indexPath.row].name
            cell?.accessoryType = .none;
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == Sections.General.rawValue
        {
            if indexPath.row == Rows.Permission.rawValue
            {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            else if indexPath.row == Rows.AboutApp.rawValue
            {
                self.navigationController?.pushViewController(AboutAppVC(), animated: true)
            }
        }
        else if indexPath.section == Sections.Language.rawValue
        {
            Helper.changeLanguage(code: langauges[indexPath.row].code);
            self.navigationController?.setViewControllers([HomeVC()], animated: true);

        }
        else if indexPath.section == Sections.CalendarMode.rawValue
        {
            Helper.changeCalendarMode();
            self.navigationController?.setViewControllers([HomeVC()], animated: true);
        }
    }
    
}
