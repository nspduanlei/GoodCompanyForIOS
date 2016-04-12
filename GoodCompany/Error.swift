//
//  Error.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

struct Error {
    enum Code: Int {
        case URLError                 = -6000
        case NetworkRequestFailed     = -6001
        case JSONSerializationFailed  = -6002
        case JSONParsingFailed        = -6003
    }
    
    let errorCode: Code
}
