//
//  LoginViewModel.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/30.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let loginBack: Observable<UserBack>
    let getCodeBack: Observable<NoBody>
    let complateDataBack: Observable<NoBody>
    let error: Observable<Error>?
    
    private var loginService: LoginServiceProtocol
    private var completeDataS: CompleteDataP
    
    init() {
        loginBack = Observable(UserBack())
        getCodeBack = Observable(NoBody())
        complateDataBack = Observable(NoBody())
        
        error = Observable(Error(errorCode: Error.Code.DEFALUT))
        loginService = LoginService()
        completeDataS = CompleteDataS()
    }
    
    func getCodeService(phoneNum: String, type: Int) {
        getVerCode(phoneNum, type: type)
    }
    
    //报错
    private func update(error: Error) {
        self.error?.value = error
    }
    
    private func getVerCodeReceived(result: NoBody) {
        getCodeBack.value = result
    }
    
    private func submitCodeReceived(result: UserBack) {
        loginBack.value = result
    }

    private func completeDataReceived(result: NoBody) {
        complateDataBack.value = result
    }
    
    //获取验证吗
    func getVerCode(phoneNum: String, type: Int) {
        loginService.getVerCode(phoneNum, type: type) {
            (data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedGoods = data else {
                    return
                }
                
                self.getVerCodeReceived(unwrappedGoods)
            }
        }
    }
    
    //登录提交验证码
    func subVerCode(phoneNum: String, code: String) {
        loginService.submitVerCode(phoneNum, code: code){
            (data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedGoods = data else {
                    return
                }
                
                self.submitCodeReceived(unwrappedGoods)
            }
        }
    }
    
    //完善资料
    func completeData(user: User) {
        completeDataS.completeData(user){
            (data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let unwrappedError = error {
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedGoods = data else {
                    return
                }
                
                self.completeDataReceived(unwrappedGoods)
            }
        }
    }
}