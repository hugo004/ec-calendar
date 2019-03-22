//
//  Helper.swift
//  ec-calendar
//
//  Created by Hugo on 20/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import EventKit

class Helper {
    
    static func localSaveEvents(data: [ECEvent], key: String) -> Void {

        let encoded = try? PropertyListEncoder().encode(data); //custom object need encode first
        UserDefaults.standard.setValue(encoded, forKey: key);
        UserDefaults.standard.synchronize();
        
    }
    
    static func localRetrieveEvents(key: String) -> [ECEvent] {
        var events: [ECEvent]?;
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            events = try? PropertyListDecoder().decode([ECEvent].self, from: data);
        }
        
        return events ?? [];
    }
    
    static func localSaveDiary(data: [Diary], key: String) -> Void {
        let encoded = try? PropertyListEncoder().encode(data); //custom object need encode first
        UserDefaults.standard.setValue(encoded, forKey: key);
        UserDefaults.standard.synchronize()
    }
    
    static func localRetrieveDiary(key: String) -> [Diary] {
        var diarys: [Diary]?;
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            diarys = try? PropertyListDecoder().decode([Diary].self, from: data);
        }
        
        return diarys ?? [];
    }
    
    static func addEventToCalendar(myEvent:ECEvent) -> Void {
        let eventStore: EKEventStore = EKEventStore();
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            if error != nil
            {
                print("Calerndar permission request error");
            }
            else
            {
                if granted
                {
                    let event: EKEvent = EKEvent(eventStore: eventStore);
                    event.title = myEvent.title;
                    event.location = myEvent.location;
                    event.notes = myEvent.remark;
                    event.startDate = myEvent.startDate;
                    event.endDate = myEvent.endDate;
                    event.calendar = eventStore.defaultCalendarForNewEvents;
                    event.addAlarm(EKAlarm(absoluteDate: event.startDate));
                    
                    do
                    {
                        try eventStore.save(event, span: EKSpan.thisEvent);
                    }catch let error as NSError
                    {
                        print("Save event error:\(error)");
                    }
                    
                }
            }
        }
    }
    
    static func requestCalendarPermission() -> Bool {
        
       var havePermission = false
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event) {
            
        case .authorized:
            havePermission = true
            break;
        case .denied:
            havePermission = false
            break
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion:
                {(granted: Bool, error: Error?) -> Void in
                    if granted {
                        print("Access granted")
                    } else {
                        print("Access denied")
                    }
            })
        default:
            break;
            
        }
        
        return havePermission
    }
    
    func string2Date(dateString:String) -> Date {
        let df:DateFormatter = DateFormatter();
        df.dateFormat = "yyyy/MM/dd HH:mm";
        return df.date(from: dateString)!;
    }
    
    
    static func date2TimeString(date:Date?) -> String {
        let df:DateFormatter = DateFormatter();
        df.dateFormat = "HH:mm";
        return (date != nil) ? df.string(from:date!) : "";
    }

    
    static func Localized(key:String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    static func changeLanguage(code:String) -> Void {
        UserDefaults.standard.set([code], forKey: "AppleLanguages");
        UserDefaults.standard.synchronize();
    }
    
    static func currentLanguage() -> String {
        return UserDefaults.standard.value(forKey: "AppleLanguages") as! String;
    }

    static func isDoubleSundayMode() -> Bool {
        guard let isDoubleSun: Bool =  UserDefaults.standard.value(forKey: "isDoubleSundayMode") as? Bool else {
            return false;
        };
        
        return isDoubleSun;
    }
    
    static func changeCalendarMode() -> Void {
        //toggle calendar between double sunday and saturday
        if (isDoubleSundayMode())
        {
            UserDefaults.standard.set(false, forKey: "isDoubleSundayMode");
        }
        else
        {
            UserDefaults.standard.set(true, forKey: "isDoubleSundayMode");
        }
    }
}
