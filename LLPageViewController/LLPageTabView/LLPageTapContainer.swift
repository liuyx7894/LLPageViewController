//
//  LLPageTapContainer.swift
//  LLPageViewController
//
//  Created by Louis Liu on 2018/12/27.
//  Copyright © 2018 Louis Liu. All rights reserved.
//

import UIKit
import Then
import SnapKit

class LLPageTapContainer: UIView {
    
    public var didMoveTo:((Int)->Void)?
    
    private var viewControllers = [UIViewController]()
    private let container = UIScrollView().with {
        $0.frame = CGRect(origin: .zero, size: CGSize(width: screenWidth, height: 60))
        $0.tag = 99
        $0.isPagingEnabled = true
        $0.alwaysBounceHorizontal = true
    }
    
    convenience init(viewControllers:[UIViewController], frame:CGRect) {
        self.init(frame: frame)
        self.viewControllers = viewControllers
        container.delegate = self
        initPageTapContainer()
    }

    func moveTo(page:Int){
        guard page < viewControllers.count else { return }
        container.setContentOffset(CGPoint(x: screenWidth * CGFloat(page), y: 0), animated: true)
    }
    
    private func initPageTapContainer(){
        addSubview(container)
        // UI
        container.snp.remakeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        for i in 0..<viewControllers.count {
            let vc = viewControllers[i]
            container.addSubview(vc.view)
            var last:UIViewController?
            if i-1 >= 0 {
                last = viewControllers[i-1]
            }
        
            vc.view.snp.remakeConstraints { (m) in
                if (last != nil) {
                    m.leading.equalTo(last!.view.snp.trailing)
                }else{
                    m.leading.equalTo(0)
                }
                if i == viewControllers.count-1{
                    m.right.equalTo(0)
                }
               
                m.bottom.top.equalToSuperview()
                m.width.equalTo(screenWidth)
                m.height.equalToSuperview()
            }
        }
    }
    
}

extension LLPageTapContainer:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didMoveTo?(Int(scrollView.contentOffset.x / screenWidth))
    }
}
