//
//  AppIntroVC.swift
//  ec-calendar
//
//  Created by Hugo on 11/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import Onboard
import SnapKit

class AppIntroVC: UIViewController {
    
    let introVC: OnboardingViewController = {
        let vc = OnboardingViewController()
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initIntroView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
    }

    func initIntroView() -> Void
    {
        let firstPage = OnboardingContentViewController(title: "First page", body: "Welcome ", image: nil, buttonText: "next", action: ({
            //TODO action
            self.introVC.moveNextPage()
            
        }))
        
        let secondPage = OnboardingContentViewController(title: "second page", body: "Welcome ", image: nil, buttonText: "next", action: ({
            //TODO action
            self.introVC.moveNextPage()
        }))
        
        let thirdPage = OnboardingContentViewController(title: "third page", body: "Welcome ", image: nil, buttonText: "next", action: ({
            //TODO action
            self.introVC.skipButton.sendActions(for: UIControl.Event.touchUpInside)
            
        }))
        //add pages
        self.introVC.viewControllers = [firstPage, secondPage, thirdPage]
        //add skip button
        self.introVC.skipButton = addSkipButton(parent: self.introVC.view)
        //add intro vc
        self.addChild(self.introVC)
        self.view.addSubview(self.introVC.view)
        

        
    }
    
    func addSkipButton(parent:UIView) -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        btn.setTitle("Skip", for: UIControl.State.normal)
        
        parent.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(parent.safeAreaLayoutGuide).offset(-20)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
        
        btn.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.navigationController?.pushViewController(TestViewController(), animated: true)
        }


        
        return btn
    }

}
