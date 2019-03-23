//
//  MonthHeaderView.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class DiaryMonthHeaderView: UIView {
    
    let left: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        btn.setTitle("<", for: .normal);
        btn.setTitleColor(UIColor.black, for: .normal)
        
        return btn
    }()
    
    let right: UIButton = {
        let btn                 = UIButton()
        btn.titleLabel?.font    = .systemFont(ofSize: 20, weight: .bold)
        
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        
        return btn
    }()
    
    let lblMonth: UILabel = {
        let lbl             = UILabel()
        lbl.text            = "Month"
        lbl.textColor       = UIColor.black
        lbl.font            = .systemFont(ofSize: 25, weight: .bold)
        lbl.numberOfLines   = 0
        lbl.lineBreakMode   = NSLineBreakMode.byWordWrapping
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(left)
        self.addSubview(right)
        self.addSubview(lblMonth)
        
        
        lblMonth.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        left.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        right.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-20)
            make.size.equalTo(left)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
