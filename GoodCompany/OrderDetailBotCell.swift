//
//  OrderDetailBotCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class OrderDetailBotCell: UITableViewCell {
    
    @IBOutlet weak var sendPrice: UILabel!
    @IBOutlet weak var payType: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    func initUi(order: Order) {
        amount.text = "¥" + order.orderAmount!
        totalPrice.text = "¥" + order.orderAmount!
    }

 }