//
//  EventVC.swift
//  ec-calendar
//
//  Created by Hugo on 18/3/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class EventVC: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let eventView = {
        return EventView();
    }();
    
    init(sourceView: UIView) {
        super.init(nibName: nil, bundle: nil);
        
        initView();
        eventView.layoutIfNeeded();
        
        self.preferredContentSize = eventView.frame.size;
        self.modalPresentationStyle = UIModalPresentationStyle.popover;
        
        let popover: UIPopoverPresentationController = self.popoverPresentationController!;
        popover.permittedArrowDirections = UIPopoverArrowDirection.any;
        popover.sourceView = sourceView;
        popover.sourceRect = sourceView.bounds;
        popover.delegate = self;
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightText
        
        
    }
    
    func initView() -> Void {
        self.view.addSubview(eventView);
        eventView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view);
            make.width.equalTo(self.view).multipliedBy(0.85)
        }
        
        eventView.cancel.reactive.controlEvents(.touchUpInside).observeValues{ _ in
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none;
    }

}
