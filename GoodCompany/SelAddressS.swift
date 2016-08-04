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

struct SelAddressS: SelAddressP {
    
    private let urlPath = Constants.TEST_BASE_URL + "area"

    func selectAreas(id: Int, completionHandler: SelectAreaCompletionHandler) -> Request {
        
        let parameters = ["id": id]
        
        return HttpUtils.getGetRequest(urlPath, parameters: parameters)
                .responseObject {
            (response: Response<SelectAreaBack, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    
}
