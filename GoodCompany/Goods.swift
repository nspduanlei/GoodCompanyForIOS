//
//  Goods.swift
//  GoodCompany
//
//  Created by 段磊 on 16/6/23.
//  Copyright © 2016年 段磊. All rights reserved.
//



import Foundation
import ObjectMapper

class Goods: Mappable {
    
    var data: [Good]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }

}