//
//  TransportInfoBack.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class TransportInfoBack: Mappable {
    
    var h: H?
    var list: [TransportItem]?
    
    init() {}
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        h <- map["h"]
        list <- map["b"]
    }

}