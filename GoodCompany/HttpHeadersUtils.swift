//
//  HttpHeadersUtils.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/31.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class HttpHeadersUtils {
    
    static func getHeader() -> Dictionary<String, String> {
        guard let token = UserUtils.getToken() else {
            return ["_c":"ios"]
        }
        return ["_c":"ios", "x-auth-token": token]
    }
    
}