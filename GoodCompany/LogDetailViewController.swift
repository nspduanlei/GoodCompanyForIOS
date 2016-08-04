//
//  LogDetailViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class LogDetailViewController: UITableViewController {
    
    var data: TransportItem?


    override func viewDidLoad() {

    }
    
    //消息在表视图显示的时候发出，询问当前节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data?.dital == nil {
            return 0
        } else {
            return (data?.dital!.count)! + 1;
        }
    }
    
    //表视图单元格显示的时候会发出， 为单元格提供显示数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("logHeaderCell")! as! LogDetailHeaderCell
            cell.initUi(self.data!)
            return cell
            
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("logCell")! as UITableViewCell
            
            let skuItem = data?.dital![indexPath.row - 1]
            
            let name  = cell.viewWithTag(100) as! UILabel
            name.text = skuItem!.skuName
            let detail = cell.viewWithTag(101) as! UILabel
            detail.text = "x\(skuItem!.num!)"
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(176)
        } else {
            return CGFloat(44)
        }
    }

}