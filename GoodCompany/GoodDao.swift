//
//  GoodDao.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/4.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import RealmSwift

class GoodDao {

    var realm: Realm

    init() {
        realm = try! Realm()
    }
    
    //添加
    func add(good: GoodData) {
        try! realm.write {
            realm.add(good, update: true)
        }
    }
    
    //查询全部商品
    func queryAll()-> Results<GoodData> {
        var result: Results<GoodData>
        result = realm.objects(GoodData)
        return result
    }
    
    //获取选择的商品
    func querySelect()-> Results<GoodData> {
        let ret = realm.objects(GoodData).filter("isSelect = \(true)")
        return ret
    }
    
    func queryGood(id: Int)-> GoodData? {
        let good = realm.objects(GoodData).filter("id = \(id)").first
        return good
    }
    
    //删除商品
    func delete(good: GoodData) {
        try! realm.write {
            realm.delete(good)
        }
    }
    
    func deleteList(goods: [GoodData]) {
        try! realm.write {
            realm.delete(goods)
        }
    }
    
    //更新商品数量
    func updateNum(good: GoodData, num: Int) {
        try! realm.write {
            good.num = num
        }
    }
    
    //更新商品的选择
    func updateSelect(good: GoodData, isSelect: Bool) {
        try! realm.write {
            good.isSelect = isSelect
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.delete(queryAll())
        }
    }
    
    //获取购物车数量
    func getCount()-> Int {
        var num = 0
        for good in queryAll() {
            num = num + good.num
        }
        return num
    }
    
    func getCountGoods() -> Int {
        return queryAll().count
    }
    
    //根据id获取,数量
    func getGoodNum(id: Int)-> Int {
        if let good = realm.objects(GoodData).filter("id = \(id)").first {
            return good.num
        }
        return 0
    }
    
    //获取总价
    func getTotalPrice() -> Int {
        var total = 0
        for good in querySelect() {
            
            let price = Int(Double(good.price)!)
            
            total = total + price * good.num
        }
        return total
    }
    
    func getCountSelect() -> Int {
        return querySelect().count
    }
    
    //是否全选
    func getIsSelectAll() -> Bool {
        return getCountSelect() == getCountGoods()
    }

}