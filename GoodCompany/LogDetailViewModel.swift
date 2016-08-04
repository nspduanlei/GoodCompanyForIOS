//
//  LogDetailViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

class LogDetailViewModel {

    let error: Observable<Error>?
    
    let back: Observable<TransportInfoBack>?
    
    var request: Request?

    private var logDetailServer: LogDetailP
    
    init() {
        back = Observable(TransportInfoBack())
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        logDetailServer = LogDetailS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    func getLogDetail(orderId: Int) {
        logDetailServer.getLogDetail(orderId) {
                (data, error) -> Void in
    
                dispatch_async(dispatch_get_main_queue()) {
                    if let unwrappedError = error {
                        self.update(unwrappedError)
                        return
                    }
    
                    guard let unwrappedGoods = data else {
    
                        return
                    }
    
                    self.onGetLogDetailReceived(unwrappedGoods)
                }
            }
    }

    
    func onGetLogDetailReceived(result: TransportInfoBack) {
        if result.h?.code == 200 {
            back?.value = result
        }
    }
}