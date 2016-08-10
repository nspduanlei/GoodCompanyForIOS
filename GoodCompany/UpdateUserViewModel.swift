//
//  UpdateUserViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/8/5.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

class UpdateUserViewModel {

    let error: Observable<Error>?
    
    let backData: Observable<NoBody>?
    
    var request: Request?

    private var updateUserServer: UpdateUserP
    
    init() {
        backData = Observable(NoBody())
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        updateUserServer = UpdateUserS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    func updateUser(user: User) {
        updateUserServer.updateUser(user) {
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
    
    func onSetDefaultReceived(result: NoBody) {
        if result.h?.code == 200 {
            backData?.value = result
        }
    }
}