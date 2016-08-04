//
//  SelectAreaBack.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class SelectAreaBack: Mappable {
    
    var h: H?
    var areas: [SelectArea]?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        h <- map["h"]
        areas <- map["b"]
    }
    init() {}
}