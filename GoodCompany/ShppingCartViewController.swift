//
//  ShppingCartViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/4/29.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var gotoPayBtn: UIButton!
    @IBOutlet weak var totalPriceL: UILabel!
    @IBOutlet weak var selectAllL: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectImg: UIButton!
    @IBOutlet weak var selectAllTxt: UILabel!
    var isSelectAll = false
    
    @IBOutlet weak var emptyView: UIView!
    
    var goodDao: GoodDao!
    var goodDatas: [GoodData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        goodDao = GoodDao()
        updateData()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodDatas.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CartListItem") as! ShoppingCartCell
        let goodData = goodDatas[indexPath.row] as GoodData
        cell.initUi(goodData, context: self)
        return cell
    }
    
    func updateData() {
        //获取全部数据
        goodDatas = goodDao.queryAll().map{$0}
        tableView.reloadData()
        
        if goodDatas.count == 0 {
            emptyView.hidden = false
        } else {
            emptyView.hidden = true
        }
        
        //是否全选
        selectAll()
        
        //更新总价、选择数量、是否全选
        totalPriceL.text = "￥\(goodDao.getTotalPrice())"
        gotoPayBtn.setTitle("去结算(\(goodDao.getCountSelect()))", forState: UIControlState.Normal)
        checkBtn.selected = goodDao.getIsSelectAll()
    }
    
    func selectAll() {
        if(goodDao.getIsSelectAll()) {
            selectImg.selected = false
            selectAllTxt.text = "全不选"
            isSelectAll = false
        } else {
            selectImg.selected = true
            selectAllTxt.text = "全选"
            isSelectAll = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "shopTrueOrder" {
            let vc = segue.destinationViewController as! TrueViewController
            vc.goods = goodDao.querySelect().map{$0}
        }
    }
    
    @IBAction func SelectAllOnClick(sender: AnyObject) {
        if isSelectAll {
            for item in goodDatas {
                if item.isSelect == false {
                    goodDao.updateSelect(item, isSelect: true)
                }
            }
        } else {
            for item in goodDatas {
                if item.isSelect == true {
                    goodDao.updateSelect(item, isSelect: false)
                }
            }
        }
        
        updateData()
    }
}



