//
//  Address.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/7.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class Address: Mappable {
    
    var province: String?
    var provinceId: String?
    var city: String?
    var cityId: Int?
    var area: String?
    var areaId: Int?
    var detail: String?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        province <- map["province"]
        provinceId <- map["provinceId"]
        city <- map["city"]
        cityId <- map["cityId"]
        area <- map["area"]
        areaId <- map["areaId"]
        detail <- map["detail"]
    }

}