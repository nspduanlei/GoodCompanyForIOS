//
//  FetchGoodsService.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

//获取收获地址列表

import Foundation
import SwiftyJSON
import Alamofire

struct GetAddressListS: GetAddressListP {
    
    private let urlPath = Constants.TEST_BASE_URL + "address/all/"

    
    func fetchAddressList(completionHandler: AddressCompletionHandler) -> Request {
        
        
        return HttpUtils.getGetRequest(urlPath)
                .responseObject {
            (response: Response<GoodsReceiptsBack, NSError>) in
            
            guard let unwrappedGoods = response.result.value else {
                completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                return
            }
            
            completionHandler(unwrappedGoods, nil)
        }
    }
    
    
}
