//
//  OrderBotCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/21.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class OrderBotCell: UITableViewCell {
    
    @IBOutlet weak var orderAmount: UILabel!
    @IBOutlet weak var sendAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var payType: UILabel!
    
    var viewModel: TrueOrderViewModel!
    var context: TrueViewController!
    var goods: [GoodData]!
    
    var addressId: Int!
    
    func initUi(viewModel: TrueOrderViewModel, context: TrueViewController, goods: [GoodData], addressId: Int) {
        self.viewModel = viewModel
        self.context = context
        self.goods = goods
        self.addressId = addressId
        
        var total = 0
        for good in goods {
            total = total + Int(Double(good.price)!) * good.num
        }
        
        orderAmount.text = "¥\(total)"
        totalAmount.text = "¥\(total)"
    }
    
    @IBAction func onOrderClicked(sender: AnyObject) {
        //拼接json， ［{"skuId":1, "num":3, "addressId":671}］
        var json = "["
        for good in goods {
            json += "{"
            json += "\"skuId\":\(good.id), \"num\":\(good.num), \"addressId\":\(addressId)"
            json += "}"
        }
        json += "]"
        viewModel?.createOrders(json)
    }
}
