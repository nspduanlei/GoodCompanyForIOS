//
//  GoodsServiceProtocol.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
//获取默认地址
typealias CompletionHandler = (GoodsReceiptBack?, Error?) -> Void

protocol GetDefaultAddressP {
    func getDefaultAddress(completionHandler: CompletionHandler) -> Request
}


