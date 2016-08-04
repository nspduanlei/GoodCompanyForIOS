//
//  UserUtils.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/31.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class UserUtils {
    static let PHONE_KEY = "phone"
    static let SHOP_NAME_KEY = "shopName"
    static let USER_ID_KEY = "userId"
    static let NAME_KEY = "name"
    static let IMAGE_KEY = "image"
    
    static let TOKEN_KEY = "authToken"
    static let LOCATION_KEY = "location"
    static let LOCATION_NAME_KEY = "lccation_name"
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    static func setUserInfo(user: User) {
        defaults.setObject(user.id, forKey: USER_ID_KEY)
        defaults.setObject(user.name, forKey: NAME_KEY)
        defaults.setObject(user.phone, forKey: PHONE_KEY)
        defaults.setObject(user.shopName, forKey: SHOP_NAME_KEY)
    }
    
    static func getUserInfo() -> User? {
        let id = defaults.stringForKey(USER_ID_KEY)
        if id == nil {
            return nil
        }
        
        let name = defaults.stringForKey(NAME_KEY)
        let phone = defaults.stringForKey(PHONE_KEY)
        let shopName = defaults.stringForKey(SHOP_NAME_KEY)

        let user = User()
        user.name = name
        user.phone = phone
        user.shopName = shopName
        return user
    }

    
    //image
    static func setImage(image: NSData) {
        //defaults.setURL(image, forKey: IMAGE_KEY)
        defaults.setObject(image, forKey: IMAGE_KEY)
    }
    
    static func getImage() -> NSData? {
        //let image = defaults.URLForKey(IMAGE_KEY)
        
        let image = defaults.objectForKey(IMAGE_KEY) as? NSData
        
        return image
    }

    //token
    static func setToken(token: String) {
        defaults.setObject(token, forKey: TOKEN_KEY)
    }
    
    static func getToken() -> String? {
        let token = defaults.stringForKey(TOKEN_KEY)
        return token
    }
    
    //location
    static func setLocation(id: Int) {
        defaults.setObject(id, forKey: LOCATION_KEY)
    }
    
    static func getLocation() -> Int? {
        let location = defaults.integerForKey(LOCATION_KEY)
        return location
    }
    
    static func setLocationName(name: String) {
        defaults.setObject(name, forKey: LOCATION_NAME_KEY)
    }
    
    static func getLocationName() -> String? {
        let name = defaults.stringForKey(LOCATION_NAME_KEY)
        return name
    }
    
    //退出登陆清除用户数据
    static func clear() {
        defaults.removeObjectForKey(TOKEN_KEY)
        defaults.removeObjectForKey(SHOP_NAME_KEY)
        defaults.removeObjectForKey(USER_ID_KEY)
        defaults.removeObjectForKey(NAME_KEY)
        defaults.removeObjectForKey(PHONE_KEY)
        defaults.removeObjectForKey(IMAGE_KEY)
    }
    
}