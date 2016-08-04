//
//  Address.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/7.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ObjectMapper

class GoodsReceipt: Mappable {
    
    var userId: Int?
    var addressId: Int?
    var name: String?
    var phone: String?
    var addrRes: Address?
    var isDefault: Bool?
    
    init() {}
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        userId <- map["userId"]
        addressId <- map["addressId"]
        name <- map["name"]
        phone <- map["phone"]
        addrRes <- map["addrRes"]
        isDefault <- map["defalut"]
    }

    func getAddressPost() -> AddressPost {
        return AddressPost(phone: self.phone!, userName: self.name!, areaId: self.addrRes!.areaId!, cityId: self.addrRes!.cityId!, detail: self.addrRes!.detail!, id: self.addressId!)
    }
    
}