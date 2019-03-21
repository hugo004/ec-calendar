//
//  EventView.swift
//  ec-calendar
//
//  Created by Hugo on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class EventView: UIView {
    let ok: UIButton = {
        let btn                 = UIButton()
        btn.backgroundColor     = UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
        btn.layer.cornerRadius  = 5.0
        btn.clipsToBounds       = true
        
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        
        return btn
        }()!
    
    let cancel: UIButton = {
        let btn                 = UIButton()
        btn.backgroundColor     = UIColor.lightGray
        btn.layer.cornerRadius  = 5.0
        btn.clipsToBounds       = true
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Cancel", for: .normal)
        
        return btn
        }()!
    
    let title: UITextField = {
        let txt     = UITextField()
        txt.placeholder = "Title";
        txt.borderStyle = .roundedRect;
        
        return txt;
    }()!
    
    let location: UITextField = {
        let txt     = UITextField()
        txt.placeholder = "Location";
        txt.borderStyle = .roundedRect;

        return txt;
    }()!
    
    let remark: UITextView = {
        let txtView = UITextView();
        txtView.layer.borderColor = UIColor.lightGray.cgColor;
        txtView.layer.borderWidth = 1;
        txtView.layer.cornerRadius = 5;
        txtView.clipsToBounds = true;
        return txtView;
    }()!
    
    var addToCalendar = false;
    let switchView: UISwitch = {
        let swt = UISwitch();
        
        return swt;
    }()
    
    let switchText: UILabel = {
        let lbl = UILabel();
        lbl.text = "Add to calendar";
        
        return lbl;
    }()
    
    
    convenience init (){
        self.init(frame: .zero)
        
        self.addSubview(ok)
        self.addSubview(cancel)
        self.addSubview(title)
        self.addSubview(location)
        self.addSubview(remark);
        self.addSubview(switchText);
        self.addSubview(switchView);

        
        self.backgroundColor    = UIColor.white
        self.layer.borderWidth  = 1.0
        self.layer.cornerRadius = 5.0
        self.layer.borderColor  = UIColor.lightGray.cgColor
        self.clipsToBounds      = true
        
        
        
        
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 300, height: 50))
        }
        
        location.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 300, height: 50))
        }
        
        remark.snp.makeConstraints { (make) in
            make.top.equalTo(location.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 300, height: 150))
        }
        
        switchView.snp.makeConstraints { (make) in
            make.top.equalTo(remark.snp.bottom).offset(10)
            make.left.equalTo(remark);
        }
        
        switchText.snp.makeConstraints { (make) in
            make.centerY.equalTo(switchView);
            make.left.equalTo(switchView.snp.right).offset(10)
        }

        
        ok.snp.makeConstraints { (make) in
            make.top.equalTo(switchView.snp.bottom).offset(20)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
        
        cancel.snp.makeConstraints { (make) in
            make.top.size.equalTo(ok)
            make.right.equalTo(ok.snp.left).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        
        
        addToolBar(txt: title)
        addToolBar(txt: location)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToolBar(txt:UITextField) -> Void {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: txt, action: #selector(txt.resignFirstResponder))
        toolbar.items = [done]
        
        txt.inputAccessoryView = toolbar
    }
    
}
