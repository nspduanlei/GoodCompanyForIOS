//
//  OrderHeaderCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/21.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class OrderHeaderCell: UITableViewCell {
    
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    func initUi(goodsReceipt: GoodsReceipt) {
        detail.text = (goodsReceipt.addrRes?.city)! + (goodsReceipt.addrRes?.area)! + (goodsReceipt.addrRes?.detail)!
        
        phoneNumber.text = goodsReceipt.phone
        userName.text = goodsReceipt.name
    }
    

}