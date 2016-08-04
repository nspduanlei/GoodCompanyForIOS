//
//  LoginService.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/30.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct LoginService: LoginServiceProtocol {
    
    private let getCodeUrl = Constants.TEST_BASE_URL + "sms/getcode"
    private let loginUrl = Constants.TEST_BASE_URL + "user/sms/login"
    
    //获取验证码
    func getVerCode(phoneNum: String, type: Int, completionHandler: GetCodeCompletionHandler) {
        
        let parameters = ["mobile": phoneNum, "type": "\(type)"]
        
        HttpUtils.getPostRequest(getCodeUrl, parameters: parameters)
            .validate()
            .responseObject {
//                (response) in
//                if let unwrappedData = response.result.value {
//                
//                    let json = JSON(unwrappedData)
//                    
//                    guard let code = json["h"]["code"].int else {
//                        let error = Error(errorCode: .JSONParsingFailed)
//                        completionHandler(error)
//                        return
//                    }
//                    
//                    if code != 200 {
//                        let error = Error(errorCode: .TEST)
//                        completionHandler(error)
//                    }
//                    
//                    let error = Error(errorCode: .SUCCESS)
//                    completionHandler(error)
//                }
                
                (response: Response<NoBody, NSError>) in
                
                guard let unwrappedGoods = response.result.value else {
                    completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                    return
                }
                
                completionHandler(unwrappedGoods, nil)
        }
    
    }
    
        
    
    //提交验证码
    func submitVerCode(phoneNum: String, code: String, completionHandler: LoginCompletionHandler) {
        let parameters = ["phone": phoneNum, "code": code]
        HttpUtils.getPostRequest(loginUrl, parameters: parameters)
            .validate()
            .responseObject {
                
                (response: Response<UserBack, NSError>) in
                
                if let token = response.response?.allHeaderFields["x-auth-token"] {
                    UserUtils.setToken(token as! String)
                }
                
                guard let unwrappedGoods = response.result.value else {
                    completionHandler(nil, Error(errorCode: Error.Code.JSONParsingFailed))
                    return
                }
                
                completionHandler(unwrappedGoods, nil)
        }
    }
    
    
    
}
