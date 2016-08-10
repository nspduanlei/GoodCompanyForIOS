//
//  UpdateUserS.swift
//  GoodCompany
//
//  Created by 段磊 on 16/8/5.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire

struct UpdateUserS: UpdateUserP {
    
    private let urlPath = Constants.TEST_BASE_URL + "user/update"

    func updateUser(user: User, completionHandler: UpdateUserCompletionHandler) -> Request {
        
        let parameters = ["userPhone": user.phone!, "userShop": user.shopName!, "userName": user.name!]
        
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