//
//  SelectArea.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class SelectArea: Mappable {
    var id: Int?
    var areaName: String?
    var parentId: Int?
    var isSelect: Bool?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        areaName <- map["areaName"]
        parentId <- map["parentId"]
        isSelect <- map["isSelect"]
    }
}