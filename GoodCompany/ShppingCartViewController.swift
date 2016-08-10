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

    @IBOutlet weak var editBtn: UIBarButtonItem!
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
    
    //编辑
    var isEdit = false
    var delCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(netHex: 0x6c6c6c)
    }
    
    override func viewWillAppear(animated: Bool) {
        goodDao = GoodDao()
        updateData()
        
        //消除多余的分割线
        self.tableView.tableFooterView = UIView()
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
        cell.initUi(goodData, context: self, isEdit: isEdit)
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
    }
    
    func updateDataForEidt() {
        tableView.reloadData()
        
        if goodDatas.count == 0 {
            emptyView.hidden = false
        } else {
            emptyView.hidden = true
        }
        
        //是否全选
        selectAll()
        
        delCount = 0
        for goodData in goodDatas {
            if goodData.isDelete == true {
                delCount = delCount + 1
            }
        }
        
        
        var totalPrice = 0
        for goodData in goodDatas {
            if goodData.isDelete {
                let price = Int(Double(goodData.price)!)
                totalPrice = totalPrice + price * goodData.num
            }
        }
        
        
        //更新总价、选择数量、是否全选
        totalPriceL.text = "￥\(totalPrice)"
        gotoPayBtn.setTitle("删除(\(delCount))", forState: UIControlState.Normal)
    }
    
    func reloadData() {
        if isEdit {
            updateDataForEidt()
        } else {
            updateData()
        }
    }
    
    func selectAll() {
        if isEdit {
            var isSelectAllEdit = false
            for goodData in goodDatas {
                if goodData.isDelete == false {
                    isSelectAllEdit = true
                    break
                }
            }
            
            isSelectAll = isSelectAllEdit
            
            if isSelectAll {
                selectImg.selected = false
                selectAllTxt.text = "全选"
            } else {
                selectImg.selected = true
                selectAllTxt.text = "全不选"
            }
            
        } else {
            if(goodDao.getIsSelectAll()) {
                selectImg.selected = true
                selectAllTxt.text = "全不选"
                isSelectAll = false
            } else {
                selectImg.selected = false
                selectAllTxt.text = "全选"
                isSelectAll = true
            }
        }
    }
    
    @IBAction func SelectAllOnClick(sender: AnyObject) {
        //编辑状态，临时修改选择状态
        if isSelectAll {
            if isEdit {
                for goodData in goodDatas! {
                    if goodData.isDelete == false {
                        goodData.isDelete = true
                    }
                }
            } else {
                for item in goodDatas {
                    if item.isSelect == false {
                        goodDao.updateSelect(item, isSelect: true)
                    }
                }
            }
        } else {
            if isEdit {
                for goodData in goodDatas! {
                    if goodData.isDelete == true {
                        goodData.isDelete = false
                    }
                }
            } else {
                for item in goodDatas {
                    if item.isSelect == true {
                        goodDao.updateSelect(item, isSelect: false)
                    }
                }
            }
        }
        reloadData()
    }
    
    @IBAction func onEditClicked(sender: AnyObject) {
        isEdit = isEdit == true ? false : true
        setEdit()
    }
    
    func setEdit() {
        if isEdit { //编辑
            editBtn.title = "完成"
        } else {  //退出编辑
            editBtn.title = "编辑"
            gotoPayBtn.setTitle("删除(\(delCount))", forState: UIControlState.Normal)
        }
        reloadData()
    }
    
    @IBAction func onActionClicked(sender: AnyObject) {
        if isEdit { //删除
            var selectEdits = [GoodData]()
            for (i, goodData) in goodDatas.enumerate() {
                if goodData.isDelete {
                    selectEdits.append(goodData)
                    goodDatas.removeAtIndex(i)
                }
            }
            goodDao.deleteSelect(selectEdits)
            updateDataForEidt()
        } else { //结算
            let sb = UIStoryboard(name:"Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("trueOrder") as! TrueViewController
            vc.goods = goodDao.querySelect().map{$0}
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func selectForEdit(id: Int, isSelect: Bool) {
        for goodDataItem in goodDatas {
            if id ==  goodDataItem.id {
                goodDataItem.isDelete = isSelect
            }
        }
    }
}



