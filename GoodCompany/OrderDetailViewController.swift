//
//  OrderDetailViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/20.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class OrderDetailViewController: UITableViewController {
    
    var orderId: Int?
    var goods: [OrderItem]!
    var order: Order?

    override func viewDidLoad() {
        viewModel = OrderDetailViewModel()
        viewModel?.getOrderDetail(orderId!)
        
    }
    
    var viewModel: OrderDetailViewModel? {
        didSet {
            viewModel?.data?.observe {
                [weak self] in
                self?.order = $0.order
                self?.goods = $0.order?.orderItems
                self?.tableView.reloadData()
                self?.hideLoading()
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
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading()
    }

    
    
    //消息在表视图显示的时候发出，询问当前节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goods == nil {
            return 0
        } else {
            return goods!.count + 2;
        }
    }
    
    //表视图单元格显示的时候会发出， 为单元格提供显示数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("trueOrderHeaderCell")! as! OrderDetailHeaderCell
            
            cell.initUi(order!)
            
            return cell
            
        } else if indexPath.row == goods!.count + 1 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("trueOrderBomCell")! as! OrderDetailBotCell
            
            cell.initUi(order!)
            
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("orderCellN")! as UITableViewCell
            
            let goodData = goods![indexPath.row - 1]
            
            let name  = cell.viewWithTag(100) as! UILabel
            name.text = goodData.sku?.skuName
            let detail = cell.viewWithTag(101) as! UILabel
            detail.text = "￥\(goodData.sku!.price!)  x\(goodData.num!)"
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(206)
        } else if indexPath.row == goods!.count + 1 {
            return CGFloat(176)
        } else {
            return CGFloat(44)
        }
    }
}