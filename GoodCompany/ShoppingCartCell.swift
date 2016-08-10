//
//  ShoppingCartCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/4.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class ShoppingCartCell: UITableViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodAttr: UILabel!
    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var isSelect: UIButton!
    
    
    @IBOutlet weak var cutBtn: UIButton!
    @IBOutlet weak var inputBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var inputBg: UIView!
    
    var isEdit = false
    var goodData: GoodData!
    var goodDao: GoodDao!
    var context: UIViewController!
    
    func initUi(goodData: GoodData, context: UIViewController, isEdit: Bool) {
        
        self.goodData = goodData
        self.goodDao = GoodDao()
        self.context = context
        self.isEdit = isEdit
        
        price.text = "¥" + goodData.price
        goodName.text = goodData.skuName
        goodAttr.text = goodData.valuesStr
        
        let num = goodData.num
        inputBtn.setTitle("\(num)", forState: UIControlState.Normal)
        
        if isEdit {
            isSelect.selected = goodData.isDelete
        } else {
            isSelect.selected = goodData.isSelect
        }
        
        if goodData.pic != "" {
            goodImage.kf_setImageWithURL(NSURL(string: goodData.pic)!)
        }
    }
    
    @IBAction func onCheckClicked(sender: AnyObject) {
        if isEdit {
            let goodsView  = context as! ShoppingCartViewController
            if isSelect.selected {
                goodsView.selectForEdit(goodData.id, isSelect: false)
            } else {
                goodsView.selectForEdit(goodData.id, isSelect: true)
            }
        } else {
            if isSelect.selected {
                goodDao.updateSelect(goodData, isSelect: false)
            } else {
                goodDao.updateSelect(goodData, isSelect: true)
            }
        }
        update()
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
    
    @IBAction func onInputClicked(sender: AnyObject) {
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
    
    func updateView() {
        ViewUtils.setShoppingCartNum(context, num: goodDao.getCount())
        update()
    }
    
    func  update() {
        let goodsView  = context as! ShoppingCartViewController
        goodsView.reloadData()
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



