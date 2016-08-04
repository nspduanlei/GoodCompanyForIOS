//
//  User.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/30.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id: String?
    var name: String?
    var phone: String?
    var shopName: String?
    var addrRes: Address?
    
    required init?(_ map: Map) {
        
    }
    
    init() {}
    
    func mapping(map: Map) {
        id <- map["userId"]
        name <- map["name"]
        phone <- map["phone"]
        shopName <- map["shopName"]
        addrRes <- map["addrRes"]
    }

}