//
//  Order.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class Order: Mappable {
    
    var id: Int?
    var orderNo: String?
    var orderAmount: String?
    var orderType: Int?
    var orderDate: String?
    var addreRes: Address?
    var orderAddress: Deliveryman?
    var orderItems: [OrderItem]?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        orderNo <- map["orderNo"]
        orderAmount <- map["orderAmount"]
        orderType <- map["orderType"]
        orderDate <- map["orderDate"]
        addreRes <- map["addreRes"]
        orderAddress <- map["orderAddress"]
        orderItems <- map["orderItems"]
    }

}