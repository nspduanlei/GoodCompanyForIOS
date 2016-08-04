//
//  GoodsServiceProtocol.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
//闭包，用于处理请求的返回
typealias AddAddressCompletionHandler = (NoBody?, Error?) -> Void

protocol AddAddressP {
    func addAddress(address: AddressPost, completionHandler: AddAddressCompletionHandler) -> Request
    
    func updateAddress(address: AddressPost, completionHandler: AddAddressCompletionHandler) -> Request
}


