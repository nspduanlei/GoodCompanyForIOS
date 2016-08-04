//
//  OrderList.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderList: Mappable {
    
    var pageNo: Int?
    var pageSize: Int?
    var dataTotal: Int?
    var pageTotal: Int?
    var data: [Order]?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        pageNo <- map["pageNo"]
        pageSize <- map["pageSize"]
        dataTotal <- map["dataTotal"]
        pageTotal <- map["pageTotal"]
        data <- map["data"]
    }

}