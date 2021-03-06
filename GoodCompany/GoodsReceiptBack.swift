//
//  AddressBack.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/7.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class GoodsReceiptBack: Mappable {
    
    var h: H?
    var b: GoodsReceipt?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        h <- map["h"]
        b <- map["b"]
    }
    init() {
    }

}