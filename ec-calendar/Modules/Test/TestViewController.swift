//
//  TestViewController.swift
//  ec-calendar
//
//  Created by Hugo on 1/2/2019.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let sam = UIButton()
        sam.layer.borderWidth = 1
        sam.setTitle("Sam's VC", for: UIControl.State.normal)
        sam.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(sam)
        sam.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(-50)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width:200, height:50))
        }
        
        let terry = UIButton()
        terry.layer.borderWidth = 1
        terry.setTitle("Terry's VC", for: UIControl.State.normal)
        terry.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(terry)
        terry.snp.makeConstraints { (make) in
            make.centerX.size.equalTo(sam)
            make.centerY.equalTo(sam).offset(50)
        }
        
        let renee = UIButton()
        renee.layer.borderWidth = 1
        renee.setTitle("Renee's VC", for: UIControl.State.normal)
        renee.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(renee)
        renee.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(sam)
            make.centerY.equalTo(terry).offset((50))
        }
        
        let hugo = UIButton()
        hugo.layer.borderWidth = 1
        hugo.setTitle("Hugo's VC", for: UIControl.State.normal)
        hugo.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(hugo)
        hugo.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(sam)
            make.centerY.equalTo(renee).offset((50))
        }
        
        // sam's vc id
        sam.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.linkToMyVC(id: "sampleVC")
        }
        
        //terry's vc id
        terry.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.linkToMyVC(id: "sampleVC")
        }
        
        //renee's vc id
        renee.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.linkToMyVC(id: "sampleVC")
        }
        
        //hugo vc id
        hugo.reactive.controlEvents(UIControl.Event.touchUpInside).observe { _ in
            self.linkToMyVC(id: "sampleVC")
        }
    }
    
    func linkToMyVC(id:String) -> Void {
        
//        let identifier: String = "sampleVC"
        let identifier: String = id
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
