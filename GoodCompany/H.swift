//
//  H.swift
//  GoodCompany
//
//  Created by 段磊 on 16/6/23.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class H: Mappable {
    
    var code: Int?
    var msg: String?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
    }

}