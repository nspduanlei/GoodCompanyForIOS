//
//  CreateOrdersP.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/21.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
//闭包，用于处理请求的返回
typealias CreateOrdersCompletionHandler = (NoBody?, Error?) -> Void

protocol CreateOrdersP {
    func createOrders(json: String, completionHandler: CreateOrdersCompletionHandler) -> Request
}