//
//  NoBody.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

import ObjectMapper

class NoBody: Mappable {
    
    var h: H?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        h <- map["h"]
    }
    init() {}
    
}