//
//  ServerViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/28.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class ServerViewController: UITableViewController {
    
    var questions: [Question] = []
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.translucent = false
        
        questions.append(Question(id: 1, question: "多定一些有优惠吗？", content: "客户您好，目前商城的商品都是统一定价，" +
            "暂时不接收议价。"))
        
        questions.append(Question(id: 2, question: "收到多久可以退换货？", content: "客户您好，建议您在签收时做好验货工作，" +
            "由于商城销售的属于食品类，对于安全性要求极高。一般签收后不支持退换货。"))
        
        questions.append(Question(id: 3, question: "有赠品吗？", content: "客户您好，商城销售的商品一般都是以页面显示的商品为准，" +
            "如页面未显示有赠品，那么该商品暂时无额外赠送。"))
        
        questions.append(Question(id: 4, question: "是否支持试用？", content: "客户您好，目前商城暂未开通试用渠道，" +
            "如后续有此服务，我们会及时通知到您。"))
        
        questions.append(Question(id: 5, question: "支持什么付款方式？", content: "客户您好，目前商城支付方式为货到付款，" +
            "支持您在收到货之后支付现金或者转账付款。"))
        
        tableView.reloadData()
    }
    
    //消息在表视图显示的时候发出，询问当前节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count + 1;
    }
    
    //表视图单元格显示的时候会发出， 为单元格提供显示数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("serverHeaderCell")! as UITableViewCell
            
            return cell
            
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("serverCell")! as UITableViewCell
            
            let question = questions[indexPath.row - 1]
            
            let name  = cell.viewWithTag(100) as! UILabel
            name.text = "\(question.id) " + question.question
            
            let detail = cell.viewWithTag(101) as! UILabel
            detail.text = question.content
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(245)
        } else {
            return CGFloat(138)
        }
    }

}