//
//  EventTableViewCell.swift
//  ec-calendar
//
//  Created by Hugo on 19/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    var title, location, remark: UILabel!;
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        initView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() -> Void
    {
        title = UILabel();
        title.font = self.textLabel?.font;
        
        location = UILabel();
        location.font = self.textLabel?.font;
        
        remark = UILabel();
    }
    
}
