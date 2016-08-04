//
//  GetOrderDetailP.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
//闭包，用于处理请求的返回
typealias GetOrderDetailCompletionHandler = (OrderBack?, Error?) -> Void

protocol GetOrderDetailP {
    func getOrderDetail(id: Int, completionHandler: GetOrderDetailCompletionHandler) -> Request
}