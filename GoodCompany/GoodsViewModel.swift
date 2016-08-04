//
//  GoodsViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

class GoodsViewModel {

    let goodsBack: Observable<GoodsBack>?
    let error: Observable<Error>?

    var request: Request?
    
    private var goodsService: GoodsServiceProtocol
    
    init() {
        goodsBack = Observable(GoodsBack())
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        goodsService = FetchGoodsService()
    }
    
    func startGoodsService(cid: Int, cityId: Int) {
        fetchGoodsList(cid, cityId: cityId)
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    //获取到数据
    private func update(goods: GoodsBack) {
        self.goodsBack?.value = goods
    }
    
    func fetchGoodsList(cid: Int, cityId: Int) {
        request = goodsService.fetchGoodsList(cid, cityId: cityId) {
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
