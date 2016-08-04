//
//  RealmTest.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/1.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTest {
    
    func test() {
    
        let myDog = Dog()
        myDog.name = "大黄"
        myDog.age = 10
        
//        let myOtherDog = Dog(value: ["name":"豆豆", "age":3])
//        
//        let myThirdDog = Dog(value: ["豆豆", 5])
        
        //向Realm中添加数据
        
        //获取默认的Realm实例， 每个线程只需要使用一次即可
        let realm = try! Realm()
        
        //通过事物将数据添加到Realm中
        try! realm.write {
            realm.add(myDog)
        }
        
        
    }
    
    


}