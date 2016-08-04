//
//  OrderDetailHeaderCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/25.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class OrderDetailHeaderCell: UITableViewCell {
    
    @IBOutlet weak var sendDetail: UILabel!
    @IBOutlet weak var sendPhone: UILabel!
    @IBOutlet weak var sendName: UILabel!
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var stateStr: UILabel!
    
    func initUi(order: Order) {
        
        sendDetail.text = order.orderAddress?.detail
        sendName.text = order.orderAddress?.name
        sendPhone.text = order.orderAddress?.phone
        orderNo.text = order.orderNo
        time.text = order.orderDate
        
        switch order.orderType! {
        case 1:
            stateStr.text = "待处理"
            break;
        case 2:
            stateStr.text = "备货中"
            break;
        case 3:
            stateStr.text = "已完成"
            break;
        case 4:
            stateStr.text = "已取消"
            break;
        case 5:
            stateStr.text = "配送中"
            break;
            
        default:
            break;
        }

    
    }
    
}