//
//  Deliveryman.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

import ObjectMapper

class Deliveryman: Mappable {
    
    var name: String?
    var phone: String?
    var detail: String?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        name <- map["name"]
        phone <- map["phone"]
        detail <- map["detail"]
    }

}