//
//  StringUtils.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/30.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class StringUtils {
    
    static func checkPhoneNumber(phoneNumber: String) -> String {
        if phoneNumber == "" {
            return "手机号不能为空！！"
        }
        
        let phonePattern = "^1[0-9]{10}$"
        let matcher = MyRegex(phonePattern)
        
        if matcher.match(phoneNumber) {
            return ""
        } else {
            return "手机号格式有误！！"
        }
    }
    
    static func checkUserName(userName: String) -> String {
        if userName == "" {
            return "收货人不能为空！！"
        }
        
        return ""
    }
    
    static func checkDetailAddress(detailAddress: String) -> String {
        if detailAddress == "" {
            return "详细地址不能为空！！"
        }
        
        return ""
    }
    
    static func checkString(str: String?) -> Bool {
        if str == nil || str == "" {
            return true
        }
        return false
    }

}