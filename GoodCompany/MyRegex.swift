//
//  MyRegex.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/30.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

struct MyRegex {
    
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
    
        regex = try? NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matchesInString(input, options: [], range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
    
    
}