//
//  DayVC.swift
//  ec-calendar
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import ReactiveCocoa

struct TimeTicket {
    var hour: Int
    var times: Array<Int>
    var unit: String
    var hide: Bool
}

class DayVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public
        var today: Date?
    
    var tableView: UITableView!
    var hour = 0;
    var hourFormat = 24;
    var hourPM = 12;
    var timeTicketCounter = 15;
    var timeTicketList: Array<TimeTicket>!
    

    func initData() -> Void
    {
        timeTicketList = [];
        var unit = "AM";
        
        for i in 0...24 {
            if i < 12
            {
                unit = "AM";
            }
            else
            {
                unit = "PM";
            }
            
            timeTicketList.append(TimeTicket(hour: i, times: [15,30,45], unit:unit, hide:true));

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initData();
        // Do any additional setup after loading the view.
        tableView = UITableView(frame: self.view.bounds, style: .grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        
        self.view.addSubview(tableView);
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return timeTicketList.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ticket: TimeTicket = timeTicketList[section];
        if (ticket.hide)
        {
            return 0;
        }
        else
        {
            return ticket.times.count;
        }
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var ticket: TimeTicket = timeTicketList[section];

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50));
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.lightText.cgColor;
        button.backgroundColor = .white;
        button.contentHorizontalAlignment = .left;
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        
        let mark = (ticket.hide) ? "+" : "-";
        
        button.setTitle("\(ticket.hour):00 \(ticket.unit) (\(mark))", for: .normal);
        button.setTitleColor(UIColor.black, for: .normal);
        
        button.reactive.controlEvents(.touchUpInside).observeValues { _ in
            ticket.hide = !ticket.hide;
            self.timeTicketList[section] = ticket;
            tableView.reloadSections(IndexSet(integer: section), with: .automatic);
        }

        return button;

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier);
        
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier);
        }
        
        let ticket = timeTicketList[indexPath.section];
        cell.textLabel?.text = ":\(String(ticket.times[indexPath.row])) min";
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc: EventVC = EventVC();
        vc.modalPresentationStyle = .custom
        self.navigationController?.present(vc, animated: true, completion: nil)
    
        vc.eventView.ok.reactive.controlEvents(.touchUpInside).observeValues { _ in
            let vcs: Array = (self.navigationController?.viewControllers)!;
            
            for  vc: UIViewController in vcs {
                if (vc.isKind(of: CalendarVC.self))
                {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
        
    }
    
    

}
