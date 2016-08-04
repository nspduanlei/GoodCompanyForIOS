//
//  ThreadUtils.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/18.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class ThreadUtils {

    let workingQueue = dispatch_queue_create("my_queue", nil)
    
    func asyncFunc1(excute: () -> Void) {
        dispatch_async(workingQueue) {
            
            
        
        }
    }
    
    func asyncFunc2(excute: () -> Void) {
        dispatch_async(workingQueue, excute)
    }
    
    

}
