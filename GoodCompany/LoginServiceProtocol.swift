//
//  LoginServiceProtocol.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/30.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

typealias LoginCompletionHandler = (UserBack?, Error?) -> Void
typealias GetCodeCompletionHandler = (NoBody?, Error?) -> Void

protocol LoginServiceProtocol {

    //提交验证码，验证是否正确
    func submitVerCode(phoneNum: String, code: String, completionHandler: LoginCompletionHandler)
    
    //获取验证码 ，向手机发送短信
    func getVerCode(phoneNum: String, type: Int, completionHandler: GetCodeCompletionHandler)

}
