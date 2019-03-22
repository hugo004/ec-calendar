//
//  DiaryDetailImageView.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 21/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class DiaryDetailView: UIView {
    
    let lblDate: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        
        return lbl
    }()
    
    let lblWeek: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        
        return lbl
    }()
    
    let lblWeather: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(lblDate)
        self.addSubview(lblWeather)
        
        lblDate.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
        
        lblWeather.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
