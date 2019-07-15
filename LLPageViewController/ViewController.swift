//
//  ViewController.swift
//  LLPageViewController
//
//  Created by Louis Liu on 2018/12/27.
//  Copyright © 2018 Louis Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .blue
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .red
        
        let i1 = LLPageItem(title: "精选", vc: vc1)
        let i2 = LLPageItem(title: "附近", vc: vc2)
        let v = LLPageTabView(items: [i1, i2], frame: screenBounds)
        
        view.addSubview(v)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

