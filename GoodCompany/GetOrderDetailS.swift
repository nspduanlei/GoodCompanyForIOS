//
//  getOrderDetailS.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

struct GetOrderDetailS: GetOrderDetailP {
    
    private let urlPath = Constants.TEST_BASE_URL + "order/app"

    func getOrderDetail(id: Int, completionHandler: GetOrderDetailCompletionHandler) -> Request {
        
        let parameters = ["id": id]
        
        return HttpUtils.getGetRequest(urlPath, parameters: parameters)
                .responseObject {
            (response: Response<OrderBack, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    
}