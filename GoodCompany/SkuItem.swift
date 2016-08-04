//
//  SkuItem.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class SkuItem: Mappable {
    
    var goodsName: String?
    var skuName: String?
    var num: Int?
    var skuId: Int?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        goodsName <- map["goodsName"]
        skuName <- map["skuName"]
        num <- map["num"]
        skuId <- map["skuId"]
    }

}