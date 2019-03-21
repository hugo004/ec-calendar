//
//  Helper.swift
//  ec-calendar
//
//  Created by Hugo on 20/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

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

}
