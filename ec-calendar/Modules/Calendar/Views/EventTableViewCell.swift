//
//  EventTableViewCell.swift
//  ec-calendar
//
//  Created by Hugo on 19/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    var title, location, remark, eventTime: UILabel!;
    
    var infoView: UIImageView!;
    
    private
    var lblTitle, lbllocation, lblRemark, lblTime: UILabel!;
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        initView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() -> Void
    {
        lblTitle = UILabel();
        lbllocation = UILabel();
        lblRemark = UILabel();
        lblTime = UILabel();
        
        lblTitle.text = "Title:";
        lbllocation.text = "Location:";
        lblRemark.text = "Remark:";
        lblTime.text = "Start Time";
        
        title = UILabel();
        
        location = UILabel();
        
        remark = UILabel();
        
        eventTime = UILabel();
        
        infoView = UIImageView();
        
        self.contentView.addSubview(title);
        self.contentView.addSubview(location);
        self.contentView.addSubview(remark);
        self.contentView.addSubview(infoView);
        self.contentView.addSubview(eventTime);
        
        self.contentView.addSubview(lblTitle);
        self.contentView.addSubview(lbllocation);
        self.contentView.addSubview(lblRemark);
        self.contentView.addSubview(lblTime);
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.left.equalTo(0).offset(20);
            make.width.equalTo(100);
        }
        
        lbllocation.snp.makeConstraints { (make) in
            make.left.width.equalTo(lblTitle);
            make.top.equalTo(lblTitle.snp.bottom).offset(10);
        }
        
        lblRemark.snp.makeConstraints { (make) in
            make.left.width.equalTo(lblTitle);
            make.top.equalTo(lbllocation.snp.bottom).offset(10);
        }
        
        lblTime.snp.makeConstraints { (make) in
            make.left.width.equalTo(lblTitle);
            make.top.equalTo(lblRemark.snp.bottom).offset(10);
            make.bottom.equalTo(0).offset(-10);
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle);
            make.left.equalTo(lblTitle.snp.right).offset(10);
        }
        
        location.snp.makeConstraints { (make) in
            make.top.equalTo(lbllocation);
            make.left.equalTo(title);
        }
        
        eventTime.snp.makeConstraints { (make) in
            make.left.equalTo(title);
            make.top.equalTo(lblTime);
        }
        
        remark.snp.makeConstraints { (make) in
            make.left.equalTo(title);
            make.top.equalTo(lblRemark);
        }
        
        infoView.snp.makeConstraints { (make) in
            make.centerY.equalTo(infoView.superview!);
            make.right.equalTo(0).offset(-10);
        }
        
    }
    
}
