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
        
        let firstPage = OnboardingContentViewController(title: Helper.Localized(key: "EC_Diary"), body: nil, image: UIImage(named: "launch"), buttonText:  Helper.Localized(key: "next"), action: ({
            //TODO action
            self.introVC.moveNextPage()
            
            
        }))
        
        let secondPage = OnboardingContentViewController(title: Helper.Localized(key: "EC_Calendar"), body: Helper.Localized(key: "second_body"), image: UIImage(named: "launch"), buttonText: Helper.Localized(key: "next"), action: ({
            //TODO action
            self.introVC.moveNextPage()
        }))
        
        
        
        let thirdPage = OnboardingContentViewController(title: Helper.Localized(key: "EC_Calendar"), body: Helper.Localized(key: "third_body"), image: UIImage(named: "acloud"), buttonText: Helper.Localized(key: "next"), action: ({
            //TODO action
            self.introVC.moveNextPage()
            
        }))
        
        let forthPage = OnboardingContentViewController(title: Helper.Localized(key: "EC_Calendar"), body: Helper.Localized(key: "forth_body"), image: UIImage(named: "tree"), buttonText: Helper.Localized(key:  "next"), action: ({
            //TODO action
            self.introVC.moveNextPage()
            
        }))
        
        let fifthPage = OnboardingContentViewController(title: Helper.Localized(key: "EC_Diary"), body: Helper.Localized(key: "fifth_body"), image: UIImage(named: "note"), buttonText: Helper.Localized(key: "next"), action: ({
            //TODO action
            self.introVC.skipButton.sendActions(for: UIControl.Event.touchUpInside)
            
        }))
        
        
        
        
        
        setPagePreferences(page: firstPage, top: 240, icon_padding: 100, title_padding: 85, bottom_padding: 70, icon_w: 150, icon_h: 130, pt: 0 )
        setPagePreferences(page: secondPage, top: 150, icon_padding: 50, title_padding: 30, bottom_padding: 70, icon_w: 150, icon_h: 130, pt: 1 )
        setPagePreferences(page: thirdPage, top: 150, icon_padding: 50, title_padding: 30, bottom_padding: 70, icon_w: 226.5, icon_h: 205, pt: 2 )
        setPagePreferences(page: forthPage, top: 150, icon_padding: 50, title_padding: 30, bottom_padding: 70, icon_w: 243.5, icon_h: 271, pt: 3 )
        setPagePreferences(page: fifthPage, top: 150, icon_padding: 50, title_padding: 30, bottom_padding: 70, icon_w: 173.5, icon_h: 196, pt: -1 )

        
        //add pages
        self.introVC.viewControllers = [firstPage, secondPage, thirdPage, forthPage, fifthPage]
        //add skip button
        self.introVC.skipButton = addSkipButton(parent: self.introVC.view)
        //add intro vc
        self.addChild(self.introVC)
        self.view.addSubview(self.introVC.view)
        
        
        
        
    }
    
    func setPagePreferences(page: OnboardingContentViewController, top: Float, icon_padding: Float, title_padding: Float, bottom_padding: Float, icon_w: Float, icon_h: Float, pt: Int) {
        page.topPadding = CGFloat(top)
        page.underIconPadding = CGFloat(icon_padding)
        page.underTitlePadding = CGFloat(title_padding)
        page.bottomPadding = CGFloat(bottom_padding)
        page.iconWidth = CGFloat(icon_w)
        page.iconHeight = CGFloat(icon_h)
        page.actionButton = setActionButton(page_type: pt)
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
            self.navigationController?.pushViewController(HomeVC(), animated: true)
        }
        
        
        
        return btn
    }
    
    
    func setActionButton(page_type: Int) -> UIButton {
        let nextButton  = UIButton(type: .custom)
        nextButton.setImage(UIImage(named: "next_arrow"), for: .normal)
//        nextButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12);
        nextButton.imageView?.contentMode = .scaleAspectFit
        nextButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        nextButton.tag = page_type
        return nextButton
    }
    @objc func buttonAction(sender: UIButton) {
        if (sender.tag == -1) { //temp hardcode
            self.introVC.skipButton.sendActions(for: UIControl.Event.touchUpInside)
        }else {
            self.introVC.moveNextPage()
        }
        
    }
    
}
