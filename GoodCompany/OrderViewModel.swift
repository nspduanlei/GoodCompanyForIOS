//
//  OrderViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/4.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class OrderViewModel{
    
    private var goodsService: GoodsServiceProtocol
    
    init() {
        goodsService = FetchGoodsService()
    }

    func startTestService() {
        test()
    }

    
    func test() {
//        goodsService.fetchGoodsListTest() {
//            (goods, error) -> Void in
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                if let unwrappedError = error {
//                    print(unwrappedError)
//                    
//                    //请求错误
//                    
//                    return
//                }
//                
//                guard let unwrappedGoods = testRes else {
//                    return
//                }
//                
//                //请求成功，
//                print(unwrappedGoods)
//                
//            }
//        }
    }

    
}