//
//  GoodsServiceProtocol.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

//闭包，用于处理请求的返回
typealias GoodsCompletionHandler = (Goods?, Error?) -> Void

protocol GoodsServiceProtocol {
    func fetchGoodsList(completionHandler: GoodsCompletionHandler)
}


