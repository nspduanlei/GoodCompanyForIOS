//
//  Setting.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/7.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UITableViewController {

    @IBOutlet weak var loginOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserUtils.getToken() != nil {
            loginOutBtn.hidden = false
        } else {
            loginOutBtn.hidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginOutClick(sender: AnyObject) {
        loginOutBtn.hidden = true
        UserUtils.clear()
        //清空购物车
        GoodDao().deleteAll()
        
        //发送通知
        NSNotificationCenter.defaultCenter().postNotificationName("updateUser", object: 0)
    }
}