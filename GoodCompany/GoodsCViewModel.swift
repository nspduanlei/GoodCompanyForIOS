//
//  GoodsViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

class GoodsCViewModel {

    let data: Observable<GoodsReceiptBack>?
    let error: Observable<Error>?

    var request: Request?
    
    private var getDefalutAddressS: GetDefaultAddressP
    
    init() {
        data = Observable(GoodsReceiptBack())
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        getDefalutAddressS = GetDefalutAddressS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    //获取到数据
    private func update(data: GoodsReceiptBack) {
        self.data?.value = data
    }
    
    func getDefalutAddress() {
        request = getDefalutAddressS.getDefaultAddress(){
            (data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedData = data else {
                    return
                }
                
                self.update(unwrappedData)
            }
        }
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
}
