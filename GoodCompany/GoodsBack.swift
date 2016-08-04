//
//  GoodsTest.swift
//  GoodCompany
//
//  Created by 段磊 on 16/6/18.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class GoodsBack: Mappable {

    
    var h: H?
    var b: Goods?
    
    init() {
    }
    
    required init?(_ map: Map) {
    
    }
    
    func mapping(map: Map) {
        h <- map["h"]
        b <- map["b"]
    }
    
    
    
}