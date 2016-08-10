//
//  OrderViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/4.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

class OrderViewController: UITableViewController {
    
    var stateId: String?
    var orders: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.translucent = false
        
        viewModel = OrdersViewModel()
        viewModel?.getOrders(stateId!)
        showLoading()
        
        //消除多余的分割线
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var viewModel: OrdersViewModel? {
        didSet {
            viewModel?.data?.observe {
                [weak self] in
                self?.hideLoading()
                self?.bindOrders($0.orderList!.data!)
            }
            
            viewModel?.calcelBack?.observe {
                [weak self] in
                self?.hideLoading()
                if  $0.h?.code == 200 {
                    self?.cancelOrderSuccess()
                }
            }
            
            viewModel?.error?.observe {
                [weak self] in
                if $0.errorCode == Error.Code.NetworkRequestFailed {
                    self?.hideLoading()
                }
                self?.hideLoading()
            }
        }
    }
    
    func updateData() {
        viewModel?.getOrders(stateId!)
    }
    
    func cancelOrderSuccess() {
        ViewUtils.showMessage(view, message: "订单取消成功")
        updateData()
    }
    
    func bindOrders(orders:[Order]) {
        self.orders = orders
        tableView.reloadData()
    }
    
    //消息在表视图显示的时候发出，询问当前节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orders == nil {
            return 0
        } else {
            return orders!.count;
        }
    }
    
    //表视图单元格显示的时候会发出， 为单元格提供显示数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("orderCell") as! OrderViewCell
        
        let order = orders![indexPath.row] as Order
        cell.initUi(order, context: self, viewModel: viewModel!)
        
        return cell
    }
    
    //cell 选择监听
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let order = orders![indexPath.row] as Order
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("orderDetail") as! OrderDetailViewController
        vc.orderId = order.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if stateId! == "3" || stateId! == "4" {
            return CGFloat(120)
        } else {
            return CGFloat(180)
        }
    }

    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading(view)
    }
}