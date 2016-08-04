//
//  OrderBack.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderBack: Mappable {
    
    var h: H?
    var order: Order?
    
    required init?(_ map: Map) {
        
    }
    
    init() {}
    
    func mapping(map: Map) {
        h <- map["h"]
        order <- map["b"]
    }

}