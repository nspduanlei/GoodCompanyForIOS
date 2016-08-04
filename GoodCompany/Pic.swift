//
//  Pic.swift
//  GoodCompany
//
//  Created by 段磊 on 16/6/23.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class Pic: Mappable {
    
    var id: Int?
    var url: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
    }

}