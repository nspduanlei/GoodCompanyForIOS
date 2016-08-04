//
//  OrderCollectionViewCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/31.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class OrderViewCell: UITableViewCell {
    
    //共计1件商品
    @IBOutlet weak var goodNum: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderState: UILabel!
    //付款金额 ¥1890.0
    @IBOutlet weak var orderAmount: UILabel!
    
    @IBOutlet weak var doBtn: UIButton!
    
    
    var order:Order!
    var context:OrderViewController!
    var viewModel: OrdersViewModel!
    
    func initUi(order:Order, context:OrderViewController, viewModel: OrdersViewModel) {
        self.order = order
        self.context = context
        self.viewModel = viewModel
        
        orderTime.text = order.orderDate
        orderAmount.text = "付款金额 ¥" + order.orderAmount!
        goodNum.text = "共计\(order.orderItems!.count)件商品"
        
        switch order.orderType! {
        case 1:
            orderState.text = "待处理"
            doBtn.setTitle("取消订单", forState: UIControlState.Normal)
            break;
        case 2:
            orderState.text = "备货中"
            doBtn.setTitle("提醒发货", forState: UIControlState.Normal)
            break;
        case 3:
            orderState.text = "已完成"
            doBtn.hidden = true
            break;
        case 4:
            orderState.text = "已取消"
            doBtn.hidden = true
            break;
        case 5:
            orderState.text = "配送中"
            doBtn.setTitle("查看物流", forState: UIControlState.Normal)
            break;
            
        default:
            break;
        }
    }
    
    @IBAction func onOrderActionClicked(sender: AnyObject) {
        
        switch order.orderType! {
        case 1:
            //取消订单
            viewModel.cancelOrder(order.id!)
            context.showLoading()
            break;
        case 2:
            //提醒发货
            
            break;
        case 5:
            //查看物流
            let sb = UIStoryboard(name:"Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LogContainer") as!
                LogContainerViewController
            vc.orderId = order.id
            
            context.navigationController?.pushViewController(vc, animated: true)
            
            break;
            
        default:
            break;
        }
    }
    

}
