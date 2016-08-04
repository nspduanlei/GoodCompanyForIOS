//
//  GoodsViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

class AddressEditViewModel {

    let error: Observable<Error>?
    
    //1:编辑， 2:添加
    let backType: Observable<Int>?
    
    var request: Request?

    private var addAddress: AddAddressP
    
    init() {
        backType = Observable(0)
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        addAddress = AddAddressS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    //添加地址
    func add(address: AddressPost) {
        addAddress.addAddress(address) {
                (data, error) -> Void in
    
                dispatch_async(dispatch_get_main_queue()) {
                    if let unwrappedError = error {
                        self.update(unwrappedError)
                        return
                    }
    
                    guard let unwrappedGoods = data else {
    
                        return
                    }
    
                    self.onSetDefaultReceived(unwrappedGoods, type:2)
                }
            }
    }
    
    
    //编辑地址
    func update(address: AddressPost) {
        addAddress.updateAddress(address) {
            (data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedGoods = data else {
                    
                    return
                }
                
                self.onSetDefaultReceived(unwrappedGoods, type:1)
            }
        }
    }

    
    func onSetDefaultReceived(data: NoBody, type: Int) {
        if data.h?.code == 200 {
            backType?.value = type
        }
    }
}
