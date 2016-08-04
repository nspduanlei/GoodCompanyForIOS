//
//  CompleteDataS.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

struct CompleteDataS: CompleteDataP {
    
    private let urlPath = Constants.TEST_BASE_URL + "user/complete"

    func completeData(user: User, completionHandler: CompleteDataCompletionHandler) -> Request {
        
        let parameters: [String: AnyObject] = ["userShop": user.shopName!, "userName": user.name!, "userCity": (user.addrRes?.cityId)!, "userAreacounty": (user.addrRes?.areaId)!, "userAddress": (user.addrRes?.detail)!]
        
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