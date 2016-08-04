//
//  OrderListBack.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderListBack: Mappable {
    
    var h: H?
    var orderList: OrderList?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        h <- map["h"]
        orderList <- map["b"]
    }
    
    init(){
    }

}