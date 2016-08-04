//
//  OrderDetailViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class OrderDetailViewModel {

    let error: Observable<Error>?
    
    let data: Observable<OrderBack>?
    
    var request: Request?

    private var getOrderDetail: GetOrderDetailP
    
    init() {
        data = Observable(OrderBack())
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        getOrderDetail = GetOrderDetailS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    //添加地址
    func getOrderDetail(id: Int) {
        getOrderDetail.getOrderDetail(id) {
                (data, error) -> Void in
    
                dispatch_async(dispatch_get_main_queue()) {
                    if let unwrappedError = error {
                        self.update(unwrappedError)
                        return
                    }
    
                    guard let unwrappedGoods = data else {
    
                        return
                    }
    
                    self.onSetDefaultReceived(unwrappedGoods)
                }
            }
    }
    
    func onSetDefaultReceived(result: OrderBack) {
        if result.h?.code == 200 {
            data?.value = result
        }
    }
}