
//
//  UIColorHex.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/23.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation


extension UIColor{

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue:CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }

}