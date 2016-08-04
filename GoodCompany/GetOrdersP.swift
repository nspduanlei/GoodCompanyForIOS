//
//  GetOrdersP.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

import Alamofire
//闭包，用于处理请求的返回
typealias OrdersCompletionHandler = (OrderListBack?, Error?) -> Void

protocol GetOrdersP {
    func getOrders(state: String, completionHandler: OrdersCompletionHandler) -> Request
}