//
//  LogContainerViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class LogContainerViewController: UIViewController {
    
    var orderId: Int?
    
    var list: [TransportItem]?
    
    override func viewDidLoad() {
        viewModel = LogDetailViewModel()
        viewModel?.getLogDetail(orderId!)
        showLoading()
    }
    
    var viewModel: LogDetailViewModel? {
        didSet {
            viewModel?.back?.observe {
                [weak self] in
                self?.list = $0.list!
                self?.initView()
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
        ViewUtils.hideLoading(view)
    }

    
    func initView() {
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
        
        style.scrollTitle = false
        
        let titles = setChildVcs().map { $0.title! }
        let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        view.addSubview(scroll)
    }
    
    func setChildVcs() -> [UIViewController] {
        
        var listView: [LogDetailViewController] = []
        
        for (index, item) in list!.enumerate() {
            let vc = storyboard!.instantiateViewControllerWithIdentifier("LogDetail") as! LogDetailViewController
            vc.title = "运单\(index+1)"
            vc.data = item
            
            listView.append(vc)
        }
        
        return listView
    }

}