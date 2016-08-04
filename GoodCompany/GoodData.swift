//
//  GoodData.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/4.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import RealmSwift

class GoodData: Object {
    
    dynamic var id = 0
    dynamic var skuName = ""
    dynamic var price = ""
    dynamic var pic = ""
    
    dynamic var valuesStr = ""

    dynamic var isSelect = true
    
    //商品数量
    dynamic var num = 0
    

    override static func primaryKey()-> String? {
        return "id"
    }
    
}