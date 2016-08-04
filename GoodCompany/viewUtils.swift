//
//  ViewUtils.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/19.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class ViewUtils {
    
    static var hub: MBProgressHUD!

    //显示加载中的提示
    static func showLoading(view: UIView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        hub = MBProgressHUD.showHUDAddedTo(view, animated: true)
        //hub.label.text = "加载中"
    }
    
    //隐藏加载中的提示
    static func hideLoading() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        if hub == nil {
            return
        }
        hub.hideAnimated(true)
    }
    
    //显示普通的文本提示
    static func showMessage(view: UIView, message: String) {
        hub = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hub.mode = MBProgressHUDMode.Text
        hub.label.text = message
        hub.hideAnimated(true, afterDelay: 1)
    }

    //设置购物车数量
    static func setShoppingCartNum(view: UIViewController, num: Int) {
        let item = view.tabBarController?.tabBar.items![1]
        if num == 0 {
            item?.badgeValue = nil
        } else {
            item?.badgeValue = "\(num)"
        }
    }
    
    //跳转到登录页
    static func gotoLogin(view: UIViewController) {
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("login")
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoView(view: UIViewController, id: String) {
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier(id)
        view.navigationController?.pushViewController(vc, animated: true)
    }
}