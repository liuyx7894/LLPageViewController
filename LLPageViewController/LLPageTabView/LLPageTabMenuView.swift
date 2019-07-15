//
//  LLPageTabMenuView.swift
//  LLPageViewController
//
//  Created by Louis Liu on 2018/12/27.
//  Copyright © 2018 Louis Liu. All rights reserved.
//

import UIKit
import Then
import SnapKit
class LLPageTabMenuView: UIView {
    
    public var moveTapTo:((Int)->Void)?
    
    private var pageSettings = [String]()
    private let margin:CGFloat = 30
    private let innerMargin:CGFloat = 10
    private var currentPage = 0
    private let container = UIView().with {
        $0.frame = CGRect(origin: .zero, size: CGSize(width: screenWidth, height: 60))
        $0.backgroundColor = .clear
        $0.tag = 99
    }
    
    private let indicator = UIView().with {
        $0.backgroundColor = UIColor(hex: "00BC71")
        $0.layer.zPosition = -999
    }

    convenience init(pages:[String], frame:CGRect) {
        self.init(frame: frame)
        pageSettings = pages
        initTabView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTabView()
    }
    
    func moveTo(page:Int) {
        guard let btn = container.subviews[page] as? UIButton else {
            return
        }
        switchTap(btn: btn)
    }
    
    
    private func initTabView() {
        
        initTabs()
        initIndicator()
    }
    
    private func initTabs(){
        for i in 0..<pageSettings.count {
            let tab = tabButton(index: i, isSelected: i==0 ? true : false)
            container.addSubview(tab)
            
            let last = container.viewWithTag(i-1)
            tab.snp.makeConstraints { (m) in
                if (last != nil) {
                    m.leading.equalTo(last!.snp.trailing).offset(innerMargin)
                }else{
                    m.leading.equalTo(margin)
                }
                
                m.top.equalToSuperview()
                m.bottom.equalTo(0)
            }
        }
        
        addSubview(container)
    }
    
    private func initIndicator(){
        container.addSubview(indicator)
        moveIndicatorTo(page: 0)
    }
    
    private func moveIndicatorTo(page:Int){
        guard let v = container.viewWithTag(page) else { return }

        indicator.snp.remakeConstraints { (m) in
            m.leading.equalTo(v.snp.leading)
            m.bottom.equalTo(v.snp.bottom).offset(-8)
            m.width.equalTo(v.snp.width)
            m.height.equalTo(5)
        }
    }
    
    private func tabButton(index:Int, isSelected:Bool)->UIButton{
        return UIButton.init(type: .custom).with {
            $0.contentVerticalAlignment = .bottom
            $0.titleLabel?.font = UIFont.systemFont(ofSize: isSelected ? 28 : 20, weight: .bold)
            $0.setTitleColor(isSelected ? .LLTap_SelectedTapColor: .LLTap_DefaultTapColor, for: .normal)
            $0.tag = index
            $0.setTitle(pageSettings[index], for: .normal)
            
            $0.addTarget(self, action: #selector(switchTap(btn:)), for: .touchUpInside)
        }
    }
    
    @objc private func switchTap(btn:UIButton){
        let selectPage = btn.tag
        guard currentPage != selectPage else { return }
        
        moveTapTo?(btn.tag)
        UIView.animate(withDuration:  0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        
            defer{ self.currentPage = selectPage }
            
            self.moveIndicatorTo(page: selectPage)
            self.selectTab(selectPage)
            self.container.layoutIfNeeded()
        })
    }
    
    private func selectTab(_ index:Int) {
        let p_view = container.subviews[currentPage] as! UIButton
        let c_view = container.subviews[index] as! UIButton
        
//        UIView.animate(withDuration: 0.3) {
            p_view.do {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                $0.setTitleColor(.LLTap_DefaultTapColor, for: .normal)
            }
            c_view.do {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
                $0.setTitleColor(.LLTap_SelectedTapColor, for: .normal)
            }
//        }
        
    }
}

public extension UIColor{
    public class var LLTap_SelectedTapColor: UIColor { get{ return UIColor(hex: "222222") } }
    public class var LLTap_DefaultTapColor: UIColor { get{ return UIColor(hex: "999999") } }
}
