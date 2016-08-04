//
//  SkuAttrValue.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class SkuAttrValue: Mappable {
    
    var id: Int?
    var name: String?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }

}