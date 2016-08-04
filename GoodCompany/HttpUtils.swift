

//
//  HttpUtlls.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/5.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

class HttpUtils {

    static func getPostRequest(url: String,
                        parameters: [String: AnyObject]? = nil)-> Request {
        return Alamofire.request(.POST, url, parameters: parameters, headers: HttpHeadersUtils.getHeader())
    }
    
    static func getGetRequest(url: String,
                       parameters: [String: AnyObject]? = nil)-> Request {
        return Alamofire.request(.GET, url, parameters: parameters, headers: HttpHeadersUtils.getHeader())
    }
}
