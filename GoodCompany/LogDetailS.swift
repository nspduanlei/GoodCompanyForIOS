//
//  LogDetailS.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

struct LogDetailS: LogDetailP {
    
    private let urlPath = Constants.TEST_BASE_URL + "logistics"

    func getLogDetail(orderId: Int, completionHandler: LogDetailCompletionHandler) -> Request {
        
        let parameters = ["orderId": orderId]
        
        return HttpUtils.getGetRequest(urlPath, parameters: parameters)
                .responseObject {
            (response: Response<TransportInfoBack, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    
}