//
//  Marco.swift
//  LLPageViewController
//
//  Created by Louis Liu on 2019/7/15.
//  Copyright © 2019 Louis Liu. All rights reserved.
//

import Foundation
import UIKit


public let screenBounds = UIScreen.main.bounds
public let screenSize   = screenBounds.size
public let screenWidth  = screenSize.width
public let screenHeight = screenSize.height
public let gridWidth : CGFloat = (screenSize.width/2)-5.0
public let navigationHeight : CGFloat = 44.0
public let statubarHeight : CGFloat = 20.0
public let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight
public var MainWindow:UIWindow? {
    return UIApplication.shared.keyWindow
}
