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
        vc.backgroundImage = UIImage(named: "finalBackground")
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initIntroView()
    }
    
    
    func initIntroView() -> Void
    {
        let firstPage = OnboardingContentViewController(title: "EC Diary", body: nil, image: UIImage(named: "launch"), buttonText: "next", action: ({
            //TODO action
            self.introVC.moveNextPage()
            
            
        }))
        
        let secondPage = OnboardingContentViewController(title: "EC Calendar", body: "A simple calendar ", image: UIImage(named: "launch"), buttonText: "next", action: ({
            //TODO action
            self.introVC.moveNextPage()
        }))
        
        
        
        let thirdPage = OnboardingContentViewController(title: "EC Calendar", body: "Easy to remember what we did in that day", image: UIImage(named: "acloud"), buttonText: "next", action: ({
            //TODO action
            self.introVC.skipButton.sendActions(for: UIControl.Event.touchUpInside)
            
        }))
        
        let forthPage = OnboardingContentViewController(title: "EC Calendar", body: "Reuse the calendar", image: UIImage(named: "tree"), buttonText: "next", action: ({
            //TODO action
            self.introVC.skipButton.sendActions(for: UIControl.Event.touchUpInside)
            
        }))
        
        let fifthPage = OnboardingContentViewController(title: "EC Diary", body: nil, image: UIImage(named: "note"), buttonText: "next", action: ({
            //TODO action
            self.introVC.skipButton.sendActions(for: UIControl.Event.touchUpInside)
            
        }))
        
        
        
        firstPage.topPadding = 70
        firstPage.underIconPadding = 20
        firstPage.underTitlePadding = 85
        firstPage.bottomPadding = 70
        firstPage.iconWidth = 250
        firstPage.iconHeight = 128

        
        
        
        
        //add pages
        self.introVC.viewControllers = [firstPage, secondPage, thirdPage, forthPage, fifthPage]
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
