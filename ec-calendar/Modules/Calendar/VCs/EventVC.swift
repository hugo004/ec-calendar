//
//  EventVC.swift
//  ec-calendar
//
//  Created by Hugo on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class EventVC: UIViewController {
    
    let eventView = {
        return EventView();
    }();

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightText

        // Do any additional setup after loading the view.
        self.view.addSubview(eventView);
        eventView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view);
            make.width.equalTo(self.view).multipliedBy(0.85)
        }
        
        eventView.cancel.reactive.controlEvents(.touchUpInside).observeValues{ _ in
            self.dismiss(animated: true, completion: nil);
        }
        
        
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
