//
//  AddressPost.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class AddressPost {

    var phone: String!
    var userName: String!
    var areaId: Int!
    var cityId: Int!
    var detail: String!
    var id: Int!
    
    init(phone:String, userName:String, areaId:Int, cityId:Int, detail:String) {
        self.phone = phone
        self.userName = userName
        self.areaId = areaId
        self.cityId = cityId
        self.detail = detail
    }
    
    init(phone:String, userName:String, areaId:Int, cityId:Int, detail:String, id:Int) {
        self.phone = phone
        self.userName = userName
        self.areaId = areaId
        self.cityId = cityId
        self.detail = detail
        self.id = id
    }
}
