//
//  TransportItem.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class TransportItem: Mappable {
    
    var orderId: Int?
    var supplierName: String?
    var name: String?
    var phone: String?
    var trackingNumber: String?
    var dital: [SkuItem]?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        orderId <- map["orderId"]
        supplierName <- map["supplierName"]
        name <- map["name"]
        phone <- map["phone"]
        trackingNumber <- map["trackingNumber"]
        dital <- map["dital"]
    }

}