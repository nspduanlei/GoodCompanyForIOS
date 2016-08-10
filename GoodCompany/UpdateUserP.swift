//
//  UpdateUserP.swift
//  GoodCompany
//
//  Created by 段磊 on 16/8/5.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
//闭包，用于处理请求的返回
typealias UpdateUserCompletionHandler = (NoBody?, Error?) -> Void

protocol UpdateUserP {
    func updateUser(user: User, completionHandler: UpdateUserCompletionHandler) -> Request
}