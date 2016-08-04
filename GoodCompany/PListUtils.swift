//
//  PListUtils.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/23.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class PListUtils{

    
    static func saveData() {
        //查找Documents目录并在其后附加数据文件名
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        let filePath = documentsDirectory.stringByAppendingPathComponent("data.plist") as String
        
        let myArray = [1,2,3]
        let array = myArray as NSArray
        array.writeToFile(filePath, atomically: true)

    
    }

}