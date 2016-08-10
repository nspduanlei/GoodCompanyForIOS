//
//  GoodsTableViewCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/6/24.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class GoodsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var addCartBtn: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var inputBg: UIView!

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var cutBtn: UIButton!
    @IBOutlet weak var inputBtn: UIButton!
    
    var goodDao: GoodDao!
    var goodData: GoodData!
    var context: UIViewController!
    
    func initUi(good: Good, context: UIViewController) {

        self.goodDao = GoodDao()
        
        
        if goodDao.queryGood(good.id!) == nil {
            self.goodData = good.getGoodData()
        } else {
            self.goodData = goodDao.queryGood(good.id!)
        }
        
        self.context = context
        
        let num = goodDao.getGoodNum(good.id!)
        //判断是否加入购物车
        if num > 0 {
            addCartBtn.hidden = true
            inputBg.hidden = false
            inputBtn.setTitle("\(num)", forState: UIControlState.Normal)
        } else {
            addCartBtn.hidden = false
            inputBg.hidden = true
        }
        
        price.text = "¥" + good.price!
        name.text = good.skuName
        
        var strAttr = ""
        for attr in good.attributeNames! {
            strAttr = strAttr + attr.attributeValues![0].name! + " "
        }
        size.text = strAttr
        
        if let pics = good.pics, let url = pics[0].url {
            pic.kf_setImageWithURL(NSURL(string: url)!)
        }
    }
    
    @IBAction func onOrderClicked(sender: AnyObject) {
        if goodData.num == 0 {
            onAddCartClicked(sender)
        }
        
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("trueOrder") as! TrueViewController
        
        if goodData.num == 0 {
            goodDao.updateNum(goodData, num: 1)
        }
        
        var tList =  [GoodData]()
        tList.append(goodData)
        vc.goods = tList
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onAddCartClicked(sender: AnyObject) {
        goodData.num = 1
        //加入购物车
        goodDao.add(goodData)
        
        updateView()
    }
    
    func updateView() {
        ViewUtils.setShoppingCartNum(context, num: goodDao.getCount())
        let goodsView  = context as! GoodsViewController
        goodsView.updateData()
    }

    @IBAction func onInputClicked(sender: AnyObject) {
        
    }
    
    @IBAction func onCutClicked(sender: AnyObject) {
        var num = Int(inputBtn.currentTitle!)!
        num = num-1
        
        if num  == 0 {
            goodDao.delete(goodData)
        } else {
            inputBtn.setTitle("\(num)", forState: UIControlState.Normal)
            goodDao.updateNum(goodData, num: num)
        }
        updateView()
    }
    
    @IBAction func onAddClicked(sender: AnyObject) {
        var num = Int(inputBtn.currentTitle!)!
        if num == Constants.MAX_COUNT {
            ViewUtils.showMessage(context.view, message: "购买数量不能超过\(Constants.MAX_COUNT)")
            return
        }
        
        num = num+1
        inputBtn.setTitle("\(num)", forState: UIControlState.Normal)
        goodDao.updateNum(goodData, num: num)
        updateView()
    }
    
    @IBAction func onCountClicked(sender: AnyObject) {
        let alertController = UIAlertController(title: "修改购买数量", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "购买数量"
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.text = self.inputBtn.currentTitle!
            textField.addTarget(self, action:#selector(self.textFieldChanged), forControlEvents:UIControlEvents.EditingChanged)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction!) -> Void in
            
            let countBtn = (alertController.textFields?.first)! as UITextField
            
            let num = Int(countBtn.text!)
            
            self.goodDao.updateNum(self.goodData, num: num!)
            self.updateView()
        }
    
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        context.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textFieldChanged(textField: UITextField) {
        let num = Int(textField.text!)
        if num > Constants.MAX_COUNT {
            textField.text = "\(Constants.MAX_COUNT)"
            ViewUtils.showMessage(context.view, message: "购买数量不能超过\(Constants.MAX_COUNT)")
        } else if num == 0 {
            textField.text = "1"
        }
    }
    
    
}