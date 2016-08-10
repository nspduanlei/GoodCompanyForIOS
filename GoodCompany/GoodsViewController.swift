//
//  GoodsViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import UIKit
import Kingfisher

class GoodsViewController: UITableViewController, ControllerProtocol, CirCleViewDelegate {
    
    var listGoods: [Good]!
    //商品类型id
    var cId: Int!
    //当前索引
    var pageIndex: Int!
    //城市id
    var cityId = 100
    
    var imageArray: [UIImage!] = [UIImage(named: "ad_1.jpg"), UIImage(named: "ad_2.jpg"), UIImage(named: "ad_3.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        
        viewModel = GoodsViewModel()
        viewModel?.startGoodsService(cId, cityId:cityId)
        showLoading()
        
        //下拉刷新
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = rc
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsViewController.updateGoods), name: "updateGoodsNew", object: nil)
        
        //消除多余的分割线
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    var viewModel: GoodsViewModel? {
        didSet {
            viewModel?.goodsBack?.observe {
                [weak self] in
                self?.listGoods = $0.b?.data
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
        ViewUtils.hideLoading(view)
    }
    
    //下拉刷新
    func refresh() {
        ViewUtils.showMessage(self.view, message: "下拉刷新")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            
            self.viewModel?.startGoodsService(self.cId, cityId:self.cityId)
            self.showLoading()
            
            self.refreshControl?.endRefreshing()
        })
    }
    
    func updateCity() {
        self.viewModel?.startGoodsService(self.cId, cityId:self.cityId)
        //self.showLoading()
    }
    
    //消息在表视图显示的时候发出，询问当前节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listGoods == nil {
            return 0
        } else {
            return listGoods.count + 1;
        }
    }
    
    //表视图单元格显示的时候会发出， 为单元格提供显示数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("CellIdentifierHeader") as! CustomHeaderCell
            
            let circleView = CirCleView(frame: CGRectMake(0, 0, self.view.frame.size.width, 155), imageArray: imageArray)
            circleView.delegate = self
            cell.addSubview(circleView)
            
            return cell
            
        } else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("CellIdentifier") as! GoodsTableViewCell
            let good = listGoods[indexPath.row - 1] as Good
            cell.initUi(good, context: self)
            
            return cell
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(155)
        } else {
            return CGFloat(135)
        }
    }
    
    //跳转传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "trueOrder" {
//            let vc = segue.destinationViewController as! TrueViewController
//            let indexPath = tableView.indexPathForSelectedRow
//            if let index = indexPath {
//                
//                var tList =  [GoodData]()
//                tList.append(listGoods[index.row].getGoodData())
//            
//                vc.goods = tList
//            }
//        }
    }
    
    
    func clickCurrentImage(currentIndxe: Int) {
        print(currentIndxe)
    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func updateGoods() {
        //ViewUtils.gotoView(self, id: "myOrder")
        let goodDao = GoodDao()
        ViewUtils.setShoppingCartNum(self, num: goodDao.getCount())
        updateData()
    }
    
}