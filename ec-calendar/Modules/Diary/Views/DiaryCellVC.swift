//
//  DiaryCellVC.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class DiaryCellVC: UITableViewCell {
    
    let lblDate: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        
        return lbl
    }()
    
    /*let lblWeek: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        
        return lbl
    }()*/
    
    let lblWeather: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        
        return lbl
    }()
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(lblDate)
        //self.contentView.addSubview(lblWeek)
        self.contentView.addSubview(lblWeather)
        
        lblDate.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.centerY.equalTo(self)
        }
        
        /*lblWeek.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
        }*/
        lblWeather.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20)
            make.centerY.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
