//
//  CompleteDataP.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
//完善资料
typealias CompleteDataCompletionHandler = (NoBody?, Error?) -> Void

protocol CompleteDataP {
    func completeData(user: User, completionHandler: CompleteDataCompletionHandler) -> Request
}