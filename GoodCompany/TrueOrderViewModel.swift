//
//  TrueOrderModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/21.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

class TrueOrderViewModel {

    let error: Observable<Error>?
    
    let data: Observable<NoBody>?
    
    var request: Request?

    private var createOrdersServer: CreateOrdersP
    
    init() {
        data = Observable(NoBody())
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        createOrdersServer = CreateOrdersS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    //批量下单
    func createOrders(json: String) {
        createOrdersServer.createOrders(json) {
                (data, error) -> Void in
    
                dispatch_async(dispatch_get_main_queue()) {
                    if let unwrappedError = error {
                        self.update(unwrappedError)
                        return
                    }
    
                    guard let unwrappedGoods = data else {
    
                        return
                    }
    
                    self.onCreateOrdresReceived(unwrappedGoods)
                }
            }
    }

    func onCreateOrdresReceived(result: NoBody) {
        data?.value = result
    }
}