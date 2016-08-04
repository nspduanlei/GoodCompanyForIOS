//
//  APIClient.swift
//  GoodCompany
//
//  Created by 段磊 on 16/6/18.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIClient<T:Mappable> {

    let alamoFireManager : Alamofire.Manager?
    
    init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 4
        configuration.timeoutIntervalForResource = 4
        self.alamoFireManager = Alamofire.Manager(configuration: configuration)
    }
    
    //let urlPath = Constants.TEST_BASE_URL + "query/sku/by/categoryId"
    
    let urlPath = "http://gank.io/api/data/iOS/20/2"
    
//    func getGoods() {
//        Alamofire.request(.GET, urlPath).responseObject {
//            (response: Response<GoodsTest, NSError>) in
//            
//            let goodsTest = response.result.value!
//            print(goodsTest)
//            
//        }
//    }
    
    

}
