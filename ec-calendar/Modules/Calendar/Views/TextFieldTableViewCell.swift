//
//  TextFieldTableViewCell.swift
//  ec-calendar
//
//  Created by Hugo on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    let title: UITextField = {
        let txt = UITextField();
        
        return txt;
    }()!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() -> Void {
        self.contentView.addSubview(title);
        
        title.snp.makeConstraints { (make) in
            make.edges.equalTo(self.title.superview!)
        }
    }

}
