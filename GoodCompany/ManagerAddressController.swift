//
//  ManagerAddressController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/24.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

var selectGoodsReceipt: GoodsReceipt?

class ManagerAddressController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableViewAddress: UITableView!
    var addressList: [GoodsReceipt]?
    
    //是否是选择状态
    var isSelect: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.translucent = false
        
        //如果没有登录，跳转到登录
        if UserUtils.getToken() == nil {
            let sb = UIStoryboard(name:"Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("login")
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            //获取数据
        }
    
        viewModel = AddressListViewModel()
        getList()
        
        //定义接收用户数据变化的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateUser), name: "updateUser", object: nil)
        //定义接收用户数据变化的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getList), name: "updateAddress", object: nil)
    }
    
    var viewModel: AddressListViewModel? {
        didSet {
            
            viewModel?.data?.observe {
                [weak self] in
                self?.addressList = $0.b
                self?.tableViewAddress.reloadData()
                self?.hideLoading()
            }
            
            viewModel?.error?.observe {
                [weak self] in
                if $0.errorCode == Error.Code.NetworkRequestFailed {
                    self?.hideLoading()
                }
                self?.hideLoading()
            }
            
            viewModel?.backType?.observe {
                [weak self] in
                self?.hideLoading()
                switch $0 {
                case 1:
                    self?.showHint("设置默认地址成功")
                    self?.getList()
                    break;
                case 2:
                    self?.showHint("删除地址成功")
                    self?.getList()
                    break;
                default:
                    
                    break;
                }
            }
        }
    }
    
    //消息在表视图显示的时候发出，询问当前节中的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addressList == nil {
            return 0
        } else {
            return addressList!.count;
        }
    }
    
    //表视图单元格显示的时候会发出， 为单元格提供显示数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("addressCell") as! AddressCell
        let address = addressList![indexPath.row] as GoodsReceipt
        cell.initUi(address, context: self)
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if isSelect {
            selectGoodsReceipt = addressList![indexPath.row] as GoodsReceipt
            
           NSNotificationCenter.defaultCenter().postNotificationName("selectAddress", object: nil)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    func updateUser() {
        if UserUtils.getToken() != nil {
            //获取数据
            
        } else {
            self.close()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func close() {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        close()
    }
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading()
    }
    
    func showHint(msg:String) {
        ViewUtils.showMessage(self.view, message: msg)
    }
    
    //设置默认地址
    func setDefaultAddress(addressId: Int) {
        viewModel?.setDefault(addressId)
        showLoading()
    }
    
    //删除地址
    func delAddress(addressId: Int) {
        viewModel?.del(addressId)
        showLoading()
    }
    
    //获取列表数据
    func getList() {
        viewModel?.fetchAddressList()
        showLoading()
    }
    
}