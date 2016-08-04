//
//  GetOrdersS.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

struct GetOrdersS: GetOrdersP {
    
    private let urlPath = Constants.TEST_BASE_URL + "orders/app"

    
    func getOrders(state: String, completionHandler: OrdersCompletionHandler) -> Request {
        
        let parameters = ["state": state]
        
        return HttpUtils.getGetRequest(urlPath, parameters: parameters)
            .responseObject {
                (response: Response<OrderListBack, NSError>) in
                
                guard let unwrappedGoods = response.result.value else {
                    completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                    return
                }
                
                completionHandler(unwrappedGoods, nil)
        }
    }
    
}