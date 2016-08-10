//
//  MyOrderController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/24.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MyOrderController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.translucent = false
        
        //修改tabbar样式
        self.tabBarController?.tabBar.tintColor = Constants.COLOR_4
        ViewUtils.setShoppingCartNum(self, num: GoodDao().getCount())
        
        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false
        
        //如果没有登录，跳转到登录
        if UserUtils.getToken() == nil {
            let sb = UIStoryboard(name:"Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("login")
            self.presentViewController(vc, animated: true, completion: nil)
        }
        initContent()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyOrderController.updateOrder), name: "orderUpdate", object: nil)
        //获取数据
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getData), name: "getData", object: nil)
    }
    
    func getData() {
        updateOrder()
    }
    
    func initContent() {
        var style = SegmentStyle()
        // 遮盖
        style.showCover = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 遮盖颜色
        style.coverBackgroundColor = UIColor.whiteColor()
        
        style.normalTitleColor = UIColor.init(netHex: 0xBBBBBB)
        style.selectedTitleColor = UIColor.init(netHex: 0x555555)
        
        style.titleMargin = 20
        style.scrollTitle = true
        
        let titles = setChildVcs().map { $0.title! }
        
        let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        
        view.addSubview(scroll)
    }
    
    func updateOrder() {
        vc1.updateData()
        vc2.updateData()
        vc3.updateData()
        vc4.updateData()
        vc5.updateData()
    }
    
    var vc1: OrderViewController!
    var vc2: OrderViewController!
    var vc3: OrderViewController!
    var vc4: OrderViewController!
    var vc5: OrderViewController!
    
    func setChildVcs() -> [UIViewController] {
        
        vc1 = storyboard!.instantiateViewControllerWithIdentifier("orderListId") as! OrderViewController
        vc1.title = "待处理"
        vc1.stateId = "1"
        
        vc2 = storyboard!.instantiateViewControllerWithIdentifier("orderListId") as! OrderViewController
        vc2.title = "备货中"
        vc2.stateId = "2"
        
        vc3 = storyboard!.instantiateViewControllerWithIdentifier("orderListId") as! OrderViewController
        vc3.title = "配送中"
        vc3.stateId = "5"
        
        vc4 = storyboard!.instantiateViewControllerWithIdentifier("orderListId") as! OrderViewController
        vc4.title = "已完成"
        vc4.stateId = "3"
        
        vc5 = storyboard!.instantiateViewControllerWithIdentifier("orderListId") as! OrderViewController
        vc5.title = "已取消"
        vc5.stateId = "4"
        
        return [vc1, vc2, vc3, vc4, vc5]
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
    
}









