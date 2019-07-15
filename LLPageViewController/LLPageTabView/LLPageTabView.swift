//
//  LLPageTabView.swift
//  LLPageViewController
//
//  Created by Louis Liu on 2018/12/28.
//  Copyright © 2018 Louis Liu. All rights reserved.
//

import UIKit
import SnapKit
public struct LLPageItem {
    var title:String = ""
    var controller:UIViewController
    init(title:String, vc:UIViewController) {
        self.title = title
        self.controller = vc
    }
}

public class LLPageTabView: UIView {

    var items = [LLPageItem]()
    
    convenience public init(items:[LLPageItem], frame:CGRect) {
        self.init(frame: frame)
        self.items = items
        
        initTabView()
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initTabView(){
        let titles = items.map { $0.title }
        let views  = items.map { $0.controller }
        
        let v = LLPageTabMenuView(pages: titles,
                                  frame:CGRect(origin: .zero, size: CGSize(width: screenWidth, height: 60)))
        self.addSubview(v)
  
        let vv = LLPageTapContainer(viewControllers: views,
                                    frame: CGRect(origin: .init(x: 0, y: 60), size: CGSize(width: screenWidth, height: screenHeight-60)))
        self.addSubview(vv)
        
        
        v.moveTapTo = {
            vv.moveTo(page: $0)
        }
        vv.didMoveTo = {
            v.moveTo(page: $0)
        }
    }
}
