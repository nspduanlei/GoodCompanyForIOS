//
//  SkuAttribute.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class SkuAttribute: Mappable {
    
    var id: Int?
    var name: String?
    
    //1 非关键属性， 2 关键属性
    var type: String?
    var attributeValues: [SkuAttrValue]?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        attributeValues <- map["attributeValues"]
    }

}