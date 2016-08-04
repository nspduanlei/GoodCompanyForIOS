//
//  GoodsViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

class AddressListViewModel {

    let data: Observable<GoodsReceiptsBack>?
    let error: Observable<Error>?
    
    //1:设置默认的地址， 2:删除地址
    let backType: Observable<Int>?

    var request: Request?
    
    private var goodsService: GetAddressListP
    private var setDefaultAddress: SetDefaultAddressP
    //private var addAddress: AddAddressP
    private var delAddress: DelAddressP
    
    init() {
        data = Observable(GoodsReceiptsBack())
        backType = Observable(0)
        
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        goodsService = GetAddressListS()
        setDefaultAddress = SetDefaultAddressS()
        //addAddress = AddAddressS()
        delAddress = DelAddressS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    //获取到数据
    private func update(goods: GoodsReceiptsBack) {
        self.data?.value = goods
    }
    
    func fetchAddressList() {
        request = goodsService.fetchAddressList() {
            (goods, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedGoods = goods else {
                    
                    return
                }
                
                self.update(unwrappedGoods)
            }
        }
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    //设置默认地址
    func setDefault (addressId: Int) {
         setDefaultAddress.setDefaultAddress(addressId) {
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
    
    //添加地址
//    func add(address: AddressPost) {
//        addAddress.addAddress(address) {
//            (data, error) -> Void in
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                if let unwrappedError = error {
//                    self.update(unwrappedError)
//                    return
//                }
//                
//                guard let unwrappedGoods = data else {
//                    
//                    return
//                }
//                
//                self.onSetDefaultReceived(unwrappedGoods, type:2)
//            }
//        }
//    }
    
    //删除地址
    func del(addressId: Int) {
        delAddress.delAddress(addressId) {
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

    
    func onSetDefaultReceived(data: NoBody, type: Int) {
        if data.h?.code == 200 {
            backType?.value = type
        }
    }
    
    
    
    
}
