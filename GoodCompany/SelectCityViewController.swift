//
//  SelectCityViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/12.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

//协议传值
protocol passValueDelegate {
    
    func passValue(cityId: Int, areaId: Int)
}

class SelectCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: passValueDelegate?
    
    @IBOutlet weak var retButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var addressList: [SelectArea]?
    
    var level = 1
    
    var areaId: Int?
    var cityId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        retButton.customView?.hidden = true
        
        viewModel = SelectAreaViewModel()
        selectCity(1)
    }
    
    @IBAction func onReturnClick(sender: AnyObject) {
        level = 1
        
        selectCity(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var viewModel: SelectAreaViewModel? {
        didSet {
            viewModel?.data?.observe {
                [weak self] in
                self?.addressList = $0.areas
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
    
    //消息在表视图显示的时候发出，询问当前节中的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addressList == nil {
            return 0
        } else {
            return addressList!.count;
        }
    }
    
    //表视图单元格显示的时候会发出， 为单元格提供显示数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressCell")! as UITableViewCell
        let selectArea = addressList![indexPath.row] as SelectArea
        let name = cell.viewWithTag(100) as! UILabel
        name.text = selectArea.areaName
        
        let imageView = cell.viewWithTag(101)
        
        if level == 1 {
            if selectArea.id == cityId {
                imageView?.hidden = false
            } else {
                imageView?.hidden = true
            }
        } else if level == 2 {
            if selectArea.id == areaId {
                imageView?.hidden = false
            } else {
                imageView?.hidden = true
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if level == 1 {
            cityId = addressList![indexPath.row].id
            
            level = 2
            selectCity(addressList![indexPath.row].id!)
        } else if level == 2 {
            areaId = addressList![indexPath.row].id
            
            //调用代理方法把值传出去
            self.delegate?.passValue(cityId!, areaId: areaId!)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading()
    }

    func selectCity(id: Int) {
        viewModel?.getAreas(id)
        showLoading()
    }
}