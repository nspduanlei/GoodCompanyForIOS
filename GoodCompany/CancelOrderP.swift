//
//  CancelOrderP.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
//闭包，用于处理请求的返回
typealias CancelOrderCompletionHandler = (NoBody?, Error?) -> Void

protocol CancelOrderP {
    func cancelOrder(orderId: Int, completionHandler: CancelOrderCompletionHandler) -> Request
}