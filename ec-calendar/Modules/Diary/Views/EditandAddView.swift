//
//  EditandAddView.swift
//  ec-calendar
//
//  Created by Ng Chi Kin on 21/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class EditandAddView: UITableViewCell{
    
    let txtInput: UITextField = {
        let txt = UITextField()
        txt.font = .systemFont(ofSize: 25, weight: .bold)
        
        return txt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //self.contentView.addSubview(lbltitle)
        self.contentView.addSubview(txtInput)
        
        /*lbltitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self.contentView).offset(20)
        }*/
        
        txtInput.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self.contentView).offset(20)
            make.size.equalTo(CGSize(width: self.contentView.frame.size.width, height: 60))
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
