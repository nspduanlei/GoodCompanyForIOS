//
//  GoodsReceiptsBack.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/8.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

class GoodsReceiptsBack: Mappable {
    
    var h: H?
    var b: [GoodsReceipt]?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        h <- map["h"]
        b <- map["b"]
    }
    init() {
    }
    
}