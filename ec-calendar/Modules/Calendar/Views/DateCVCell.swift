//
//  DateCVCell.swift
//  ec-calendar
//
//  Created by Hugo on 18/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class DateCVCell: UICollectionViewCell {
    
    let lblDate: UILabel = {
        let lbl                 = UILabel()
        lbl.numberOfLines       = 0
        lbl.text                = "32"
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.contentView.addSubview(lblDate)
        self.contentView.layer.borderWidth  = 1.0
        self.contentView.layer.borderColor  = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = frame.size.width / 2
        self.contentView.clipsToBounds      = true
        
        lblDate.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
