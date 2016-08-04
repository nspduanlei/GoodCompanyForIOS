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
    
    //let stepper = SnappingStepper(frame: CGRect(x: 246, y: 78, width: 97, height: 31))
    
    var goodData: GoodData!
    var goodDao: GoodDao!
    var context: UIViewController!
    
    func initUi(goodData: GoodData, context: UIViewController) {
        
        self.goodData = goodData
        self.goodDao = GoodDao()
        self.context = context
        
        price.text = "¥" + goodData.price
        goodName.text = goodData.skuName
        goodAttr.text = goodData.valuesStr
        
        let num = goodData.num
        inputBtn.setTitle("\(num)", forState: UIControlState.Normal)
        
        isSelect.selected = goodData.isSelect
        
        if goodData.pic != "" {
            goodImage.kf_setImageWithURL(NSURL(string: goodData.pic)!)
        }
    }

    
    @IBAction func onCheckClicked(sender: AnyObject) {
        if isSelect.selected {
            goodDao.updateSelect(goodData, isSelect: false)
        } else {
            goodDao.updateSelect(goodData, isSelect: true)
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
        goodsView.updateData()
    }
}



