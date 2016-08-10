//
//  AddressDetailViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/6/3.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0
import SwiftyJSON

class AddressDetailViewController: UITableViewController, ControllerProtocol, ActionSheetCustomPickerDelegate {
    
    @IBOutlet weak var receivedName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var cityAndArea: UILabel!
    @IBOutlet weak var detailAddress: UITextView!
    
    var cityId: Int!
    var areaId: Int!
    
    var index1 = 0
    var index2 = 0
    
    var countryArr: [String] = []
    var districtArr: [String] = []
    
    var countryIDArr: [Int] = []
    var districtIDArr: [Int] = []
    
    var address: AddressPost?
    
    var isEdit: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let addressNew = address {
            cityId = addressNew.cityId
            areaId = addressNew.areaId
            isEdit = true
            
            receivedName.text = addressNew.userName
            phoneNumber.text = addressNew.phone
            detailAddress.text = addressNew.detail
        }
        
        initData()
        viewModel = AddressEditViewModel()
    }
    
    var viewModel: AddressEditViewModel? {
        didSet {
            viewModel?.error?.observe {
                [weak self] in
                if $0.errorCode == Error.Code.NetworkRequestFailed {
                    self?.hideLoading()
                }
                self?.hideLoading()
            }
            
            viewModel?.backType?.observe {
                [weak self] in
                self?.hideLoading()
                switch $0 {
                case 1:
                    self?.showHint("编辑地址成功")
                    //发送通知
                    NSNotificationCenter.defaultCenter().postNotificationName("updateAddress", object: 0)
                    NSNotificationCenter.defaultCenter().postNotificationName("updateUser", object: nil)
                    self?.navigationController?.popViewControllerAnimated(true)
                    break;
                case 2:
                    self?.showHint("添加地址成功")
                    //发送通知
                    NSNotificationCenter.defaultCenter().postNotificationName("updateAddress", object: 0)
                    self?.navigationController?.popViewControllerAnimated(true)
                    break;
                default:
                    
                    break;
                }
            }
        }
    }
    
    func showHint(msg:String) {
        ViewUtils.showMessage(self.view, message: msg)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading(view)
    }
    
    @IBAction func onSaveClicked(sender: AnyObject) {
        
        let name = receivedName.text!
        let phone = phoneNumber.text!
        let detail = detailAddress.text!
        
        let hintName = StringUtils.checkUserName(name)
        let hintPhone = StringUtils.checkPhoneNumber(phone)
        let hintDetail = StringUtils.checkDetailAddress(detail)
        
        if hintName != "" {
            ViewUtils.showMessage(self.view, message: hintName)
        } else if hintPhone != "" {
            ViewUtils.showMessage(self.view, message: hintPhone)
        } else if hintDetail != "" {
            ViewUtils.showMessage(self.view, message: hintDetail)
        } else if cityId == nil {
            ViewUtils.showMessage(self.view, message: "请选择城市和区")
        } else {
            //保存地址
            if address == nil { //添加地址
                address = AddressPost(phone: phone, userName: name, areaId: areaId!, cityId: cityId!, detail: detail)
                viewModel?.add(address!)
            } else { //编辑地址
                if name == address?.userName && phone == address?.phone &&
                    areaId == address?.areaId && cityId == address?.cityId && detail == address?.detail {
                    ViewUtils.showMessage(self.view, message: "没有修改")
                    return
                }
                
                address?.phone = phone
                address?.cityId = cityId
                address?.areaId = areaId
                address?.detail = detail
                address?.userName = name
                
                viewModel?.update(address!)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            print("test")
            
            let picker = ActionSheetCustomPicker.init(title: "选择地址", delegate: self, showCancelButton: true, origin: self.view, initialSelections: [index1, index2])
            
            picker.tapDismissAction = TapAction.Success
            
            picker.setDoneButton(UIBarButtonItem(title: "确定", style: .Plain, target: nil, action: nil))
            picker.setCancelButton(UIBarButtonItem(title: "取消", style: .Plain, target: nil, action: nil))
            picker.showActionSheetPicker()
            view.endEditing(true)
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.index1 = row
            self.index2 = 0
            
            calculateFirstData()
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            
            break
        case 1:
            self.index2 = row
            break
            
        default:
            
            break
        }
    }

    var json: JSON!
    
    func initData () {
        let path = NSBundle.mainBundle().pathForResource("../address", ofType: "json")
        let jsonStr = NSData(contentsOfFile: path!)
        json = JSON(data: jsonStr!)
        
        var addressStr = ""
        
        for (i, jsonObj) in json.array!.enumerate() {
            let name = jsonObj["name"].string
            let id = jsonObj["id"].int
        
            if cityId == id {
                index1 = i
                addressStr = addressStr + name!
                
            }
            countryArr.append(name!)
            countryIDArr.append(id!)
        }
        
        //填充区
        for (i, jsonObj) in json.array![index1]["area"].array!.enumerate() {
            let name = jsonObj["name"].string
            let id = jsonObj["id"].int
            
            if areaId == id {
                index2 = i
                addressStr = addressStr + name!
            }
            
            districtArr.append(name!)
            districtIDArr.append(id!)
        }
        
        if !StringUtils.checkString(addressStr) {
            cityAndArea.text = addressStr
        }
    }
    
    func calculateFirstData() {
        districtArr = []
        districtIDArr = []
        for jsonObj in json.array![index1]["area"].array! {
            let name = jsonObj["name"].string
            let id = jsonObj["id"].int
        
            districtIDArr.append(id!)
            districtArr.append(name!)
        }
    }
    
    func actionSheetPickerDidSucceed(actionSheetPicker: AbstractActionSheetPicker!, origin: AnyObject!) {
        
        cityId = countryIDArr[index1]
        areaId = districtIDArr[index2]
        
        print("list--\(districtIDArr)")
        
        print("selectCityId-----\(cityId)")
        print("selectAreaId-----\(areaId)")
        
        cityAndArea.text = countryArr[index1] + districtArr[index2]
        
    }
    
    func actionSheetPickerDidCancel(actionSheetPicker: AbstractActionSheetPicker!, origin: AnyObject!) {

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return countryArr.count

        case 1:
            return districtArr.count
            
        default:
            break
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return countryArr[row]
        case 1:
            return districtArr[row]
            
        default:
            break
        }
        return nil
    }
    
    func configurePickerView(pickerView: UIPickerView!) {
        pickerView.showsSelectionIndicator = false
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var label = view as? UILabel
        
        if label == nil {
            label = UILabel.init()
            label?.font = UIFont(name: "system", size: 14)
        }
        
        var title = ""
        
        switch component {
        case 0:
            title = countryArr[row]
            break
            
        case 1:
            title = districtArr[row]
            break
        default:
            break
        }
        
        label?.textAlignment = NSTextAlignment.Center
        label?.text = title
        
        return label!
    }

}











