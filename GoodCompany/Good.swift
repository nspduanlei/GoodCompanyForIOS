
//
//  Goods.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class Good: Mappable {
    
    var id: Int?
    var skuName: String?
    var price: String?
    var pics: [Pic]?
    var attributeNames: [SkuAttribute]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        skuName <- map["skuName"]
        price <- map["price"]
        pics <- map["pics"]
        attributeNames <- map["attributeNames"]
    }
    
    func getGoodData()-> GoodData {
        
        let goodData = GoodData()
        
        goodData.id = id!
        goodData.skuName = skuName!
        goodData.price = price!
        
        if let picsN = pics, let url = picsN[0].url {
            goodData.pic = url
        }
    
        var strAttr = ""
        for attr in attributeNames! {
            strAttr = strAttr + attr.attributeValues![0].name! + " "
        }
        goodData.valuesStr = strAttr
    
        return goodData
    }
    
}
