//
//  FetchGoodsService.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//
//获取商品列表

import Foundation
import SwiftyJSON
import Alamofire

struct AddAddressS: AddAddressP {
    
    private let urlPath = Constants.TEST_BASE_URL + "address/add"
    private let urlPathUpdate = Constants.TEST_BASE_URL + "address/update"
    
    func addAddress(address: AddressPost, completionHandler: AddAddressCompletionHandler) -> Request {
        
        let parameters: [String: AnyObject] = ["takeGoodsPhone":address.phone,"takeGoodsUser":address.userName,"addreAreacounty":address.areaId, "addreCity":address.cityId,"addreDetailAddress":address.detail]
        
        return HttpUtils.getPostRequest(urlPath, parameters: parameters).responseObject {
            (response: Response<NoBody, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    func updateAddress(address: AddressPost, completionHandler: AddAddressCompletionHandler) -> Request {
        
        let parameters: [String: AnyObject] = ["addressId":address.id, "takeGoodsPhone":address.phone,"takeGoodsUser":address.userName,"addreAreacounty":address.areaId, "addreCity":address.cityId,"addreDetailAddress":address.detail]
        
        return HttpUtils.getPostRequest(urlPathUpdate, parameters: parameters).responseObject {
            (response: Response<NoBody, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    
}
