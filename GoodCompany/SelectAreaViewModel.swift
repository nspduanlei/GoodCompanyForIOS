//
//  GoodsViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

class SelectAreaViewModel {

    let data: Observable<SelectAreaBack>?
    let error: Observable<Error>?
    var request: Request?
    var goodsService: SelAddressP
    
    init() {
        data = Observable(SelectAreaBack())
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        goodsService = SelAddressS()
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    //获取到数据
    private func update(goods: SelectAreaBack) {
        self.data?.value = goods
    }
    
    func getAreas(id: Int) {
        request = goodsService.selectAreas(id) {
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
    
}
