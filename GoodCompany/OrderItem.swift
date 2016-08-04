//
//  OrderItem.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderItem: Mappable {
    
    var id: Int?
    var sku: Good?
    var num: Int?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        sku <- map["sku"]
        num <- map["num"]
    }

}