//
//  OrdersViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

class OrdersViewModel {

    let error: Observable<Error>?
    
    let data: Observable<OrderListBack>?
    let calcelBack: Observable<NoBody>?
    
    var request: Request?

    private var getOrderServer: GetOrdersP
    private var cancelOrderServer: CancelOrderP
    
    init() {
        data = Observable(OrderListBack())
        calcelBack = Observable(NoBody())
        
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        getOrderServer = GetOrdersS()
        cancelOrderServer = CancelOrderS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    //根据状态获取订单列表
    func getOrders(state: String) {
        getOrderServer.getOrders(state) {
            (data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedGoods = data else {
                    return
                }
                
                self.onOrdersReceived(unwrappedGoods)
            }
        }
    }
    
    //取消订单
    func cancelOrder(orderId: Int) {
        cancelOrderServer.cancelOrder(orderId) {
            (data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedGoods = data else {
                    return
                }
                
                self.onCancelOrderReceived(unwrappedGoods)
            }
        }
    }
    
    func onOrdersReceived(orderListBack: OrderListBack) {
        if orderListBack.h?.code == 200 {
            data?.value = orderListBack
        }
    }
    
    
    func onCancelOrderReceived(result: NoBody) {
        if result.h?.code == 200 {
            calcelBack?.value = result
        }
    }
}