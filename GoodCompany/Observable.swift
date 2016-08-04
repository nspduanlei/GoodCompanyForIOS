//
//  Observable.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class Observable<T> {
    typealias Observer = T -> Void
    
    var observer: Observer?
    
    func observe(observer: Observer?) {
        self.observer = observer
        //observer?(value)
    }
    
    var value: T {
        didSet {
            observer?(value) //执行闭包的方法
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
