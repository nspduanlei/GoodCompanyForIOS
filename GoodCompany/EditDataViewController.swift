//
//  EditDataViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/8/4.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class EditDataViewController:UIViewController {
    

    @IBOutlet weak var dataText: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        viewModel = UpdateUserViewModel()
        
        user = UserUtils.getUserInfo()
        dataText.text = user.shopName
    }
    
    var viewModel: UpdateUserViewModel? {
        didSet {
            viewModel?.backData?.observe {
                [weak self] in

                self?.hideLoading()
                if $0.h?.code == 200 {
                    self?.updateUserSuccess()
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
    
    func updateUserSuccess() {
        ViewUtils.showMessage(view, message: "提交成功")
        UserUtils.setUserInfo(self.user)
        ViewUtils.popView(self)
        
        NSNotificationCenter.defaultCenter().postNotificationName("updateUser", object: nil)
    }
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading(view)
    }

    @IBAction func onSaveData(sender: AnyObject) {
        let shopName = dataText.text
        if StringUtils.checkString(shopName) {
            ViewUtils.showMessage(view, message: "商铺名不能为空")
            return
        }
        
        if shopName != user.shopName {
            user.shopName = shopName
            viewModel?.updateUser(user)
        } else {
            ViewUtils.popView(self)
        }
    }
}