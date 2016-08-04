//
//  MeViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/29.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

class MeViewController: UITableViewController {
    
    
    @IBOutlet weak var userHeader: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userNameBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        //定义接收用户数据变化的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MeViewController.updateUser), name: "updateUser", object: nil)
        
        updateUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUser() {
        if UserUtils.getToken() != nil {
            loginBtn.hidden = true
            userNameBtn.hidden = false
            
            userNameBtn.setTitle(UserUtils.getUserInfo()?.shopName, forState: UIControlState.Normal)
            
            if let dataImage = UserUtils.getImage() {
                let imageN = UIImage(data: dataImage)
                
                userHeader.image = imageN
                
            } else {
                userHeader.image = UIImage(named:"default_header")
            }
            
        } else {
            loginBtn.hidden = false
            userNameBtn.hidden = true
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
        print("test")
    }
}