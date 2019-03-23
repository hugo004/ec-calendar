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
    
    var today: ECDay!
    
    var tableView: UITableView!
    var hour = 0;
    var hourFormat = 24;
    var hourPM = 12;
    var timeTicketCounter = 15;
    var timeTicketList: Array<TimeTicket>!
    
     init(day: ECDay) {
        super.init(nibName: nil, bundle: nil);
        self.today = day;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        tableView.backgroundColor = UIColor.white;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        self.view.addSubview(tableView);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationItem.title = today?.toString();
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
        
        let header = UIView();
        header.backgroundColor = UIColor.white;
        
        let line = UIView();
        line.backgroundColor = UIColor.lightGray

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50));
        button.backgroundColor = .white;
        button.contentHorizontalAlignment = .left;
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        
        button.setTitle("\(ticket.hour):00 \(ticket.unit)", for: .normal);
        button.setTitleColor(UIColor.lightGray, for: .normal);
        
        button.reactive.controlEvents(.touchUpInside).observeValues { _ in
            ticket.hide = !ticket.hide;
            self.timeTicketList[section] = ticket;
            tableView.reloadSections(IndexSet(integer: section), with: .automatic);
        }
        
        
        header.addSubview(line);
        header.addSubview(button);
        
        button.snp.makeConstraints { (make) in
            make.centerY.equalTo(header);
            make.left.equalTo(header).offset(10);
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        line.snp.makeConstraints { (make) in
            make.centerY.equalTo(header);
            make.left.equalTo(button.snp.right);
            make.right.equalTo(header);
            make.height.equalTo(1);
        }
        
        
        return header;

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell";
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier);
        
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier);
        }
        
        let ticket = timeTicketList[indexPath.section];
        cell.textLabel?.text = ":\(String(ticket.times[indexPath.row]))";
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eventVc: EventVC = EventVC();
        eventVc.modalPresentationStyle = .custom
        self.navigationController?.present(eventVc, animated: true, completion: nil)
        
        let eventView = eventVc.eventView;
    
        //MARK: - add event
        eventView.ok.reactive.controlEvents(.touchUpInside).observeValues { _ in
            eventVc.dismiss(animated: true, completion: {
               var event = ECEvent(
                    title: eventView.title.text!,
                    location: eventView.location.text!,
                    remark: eventView.remark.text!
                )
                
                //set event date time
                let ticket = self.timeTicketList[indexPath.section];
                let daateStr = "\(self.today.toString()) \(indexPath.section):\(ticket.times[indexPath.row])";
                event.startDate = self.stringToDateTime(dateString: daateStr);
                event.endDate = event.startDate;
                
                //retrive previous event if have
                let key = "\(LocalDataKey.Event)-\(self.today.idString())";
                var eventList = Helper.localRetrieveEvents(key: key);
                eventList.append(event);
                
                //save event to local, key format: event-20190320
                Helper.localSaveEvents(data: eventList, key: key);
                if (eventView.switchView.isOn)
                {
                    Helper.addEventToCalendar(myEvent: event);
                }
                self.backToCalendar();
            })
        }
        
    }
    
    func backToCalendar() -> Void {
        let vcs: Array = (self.navigationController?.viewControllers)!;
        
        for  vc: UIViewController in vcs {
            if (vc.isKind(of: CalendarVC.self))
            {
                self.navigationController?.popToViewController(vc, animated: true)
                return;
            }
        }
        
        self.navigationController?.popViewController(animated: true);

    }
    
    func stringToDateTime(dateString:String) -> Date {
        let df:DateFormatter = DateFormatter();
        df.dateFormat = "yyyy/MM/dd HH:mm";
        return df.date(from: dateString)!;
    }
    

}
