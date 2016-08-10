//
//  TureOrderViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/5.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

class TrueViewController: UITableViewController {
    
    var goods: [GoodData]?
    var trueGoodsReceipt: GoodsReceipt?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogin()
        self.tabBarController?.tabBar.translucent = false
    
        viewModel = TrueOrderViewModel()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.selectAddress), name: "selectAddress", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.loginMsgDeal), name: "loginMsg", object: nil)
        
        //消除多余的分割线
        tableView.tableFooterView = UIView()
    }
    
    func loginMsgDeal() {
        self.trueGoodsReceipt = goodsReceipt
        tableView.reloadData()
    }
    
    func selectAddress() {
        self.trueGoodsReceipt = selectGoodsReceipt
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func isLogin() {
        //如果没有登录，跳转到登录
        if UserUtils.getToken() == nil {
            let sb = UIStoryboard(name:"Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("login")
            
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            //获取数据
            if goodsReceipt != nil {
                self.trueGoodsReceipt = goodsReceipt
                tableView.reloadData()
            }
        }
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
        
        if trueGoodsReceipt == nil {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("trueOrderHeaderCell")! as! OrderHeaderCell
            
            cell.initUi(self.trueGoodsReceipt!)
            
            return cell
            
        } else if indexPath.row == goods!.count + 1 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("trueOrderBomCell")! as! OrderBotCell
    
            cell.initUi(viewModel!, context: self, goods: goods!, addressId: (trueGoodsReceipt?.addressId)!)
            
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("orderCellN")! as UITableViewCell
            
            let goodData = goods![indexPath.row - 1]
            
            let name  = cell.viewWithTag(100) as! UILabel
            name.text = goodData.skuName
            let detail = cell.viewWithTag(101) as! UILabel
            detail.text = "￥\(goodData.price)  x\(goodData.num)"
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(100)
        } else if indexPath.row == goods!.count + 1 {
            return CGFloat(279)
        } else {
            return CGFloat(44)
        }
    }
    
    var viewModel: TrueOrderViewModel? {
        didSet {
            viewModel?.data?.observe {
                [weak self] in
                
                self?.hideLoading()
                if $0.h?.code == 200 {
                    self?.orderSuccess()
                } else if $0.h?.code == 3006 {
                    ViewUtils.showMessage((self?.view)!, message: "商品所在城市和收获地址不匹配")
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
    
    func orderSuccess() {
        ViewUtils.showMessage(self.view, message: "下单成功")
        //ViewUtils.gotoView(self, id: "myOrder")
        //删除购物车数据
        let goodDao = GoodDao()
        goodDao.deleteList(goods!)
        
        NSNotificationCenter.defaultCenter().postNotificationName("updateGoodsNew", object: nil)
        
        ViewUtils.gotoView(self, id: "myOrder")
        
        var marr = self.navigationController?.viewControllers
        for (index, vc) in marr!.enumerate() {
            if vc.isKindOfClass(TrueViewController) {
                marr?.removeAtIndex(index)
                break
            }
        }
        self.navigationController?.viewControllers = marr!
    }
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func close() {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        print("test")
        close()
    }
    
    //跳转传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectAddressSegue" {
            let vc = segue.destinationViewController as! ManagerAddressController
            vc.isSelect = true
        }
    }
}