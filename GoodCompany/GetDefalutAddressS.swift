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

struct GetDefalutAddressS: GetDefaultAddressP {
    
    private let urlPath = Constants.TEST_BASE_URL + "address/default"

    
    func getDefaultAddress(completionHandler: CompletionHandler) -> Request {
        
        return HttpUtils.getGetRequest(urlPath)
                .responseObject {
            (response: Response<GoodsReceiptBack, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    
}
