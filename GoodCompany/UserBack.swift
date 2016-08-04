//
//  UserBack.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class UserBack: Mappable {
    
    var h: H?
    var user: User?
    
    required init?(_ map: Map) {
        
    }
    
    init(){}
    func mapping(map: Map) {
        h <- map["h"]
        user <- map["b"]
    }

}