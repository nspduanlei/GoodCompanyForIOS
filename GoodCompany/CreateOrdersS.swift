//
//  CreateOrdersS.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/21.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

struct CreateOrdersS: CreateOrdersP {
    
    private let urlPath = Constants.TEST_BASE_URL + "order/addBatch/app"

    func createOrders(json: String, completionHandler: CreateOrdersCompletionHandler) -> Request {
        
        let parameters = ["orderJson": json]
        
        return HttpUtils.getPostRequest(urlPath, parameters: parameters)
                .responseObject {
            (response: Response<NoBody, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    
}