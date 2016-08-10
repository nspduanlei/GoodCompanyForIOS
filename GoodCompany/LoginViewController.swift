//
//  LoginViewController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/30.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0
import SwiftyJSON

class LoginViewController: UITableViewController {
    
    @IBOutlet weak var firstLoginCell: UITableViewCell!
    @IBOutlet weak var shopNameCell: UITableViewCell!
    @IBOutlet weak var userNameCell: UITableViewCell!
    @IBOutlet weak var detailCell: UITableViewCell!
    @IBOutlet weak var addressCell: UITableViewCell!
    @IBOutlet weak var startCell: UITableViewCell!
    
    
    @IBOutlet weak var addressInput: UIButton!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var shopNameInput: UITextField!
    @IBOutlet weak var detailInput: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var verCode: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var verBtn: UIButton!
    
    
    let COUNT = 60
    //倒计时
    var second: Int!
    
    var timer = NSTimer()
    var timerRunning = false
    var phoneStr: String!

    //var delegate: ChildViewControllerDelegate?
    
    //选择城市
    
    var cityId: Int!
    var areaId: Int!
    
    var index1 = 0
    var index2 = 0
    
    var countryArr: [String] = []
    var districtArr: [String] = []
    
    var countryIDArr: [Int] = []
    var districtIDArr: [Int] = []
    var json: JSON!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.translucent = false
        
        second = COUNT
        loginBtn.enabled = false
        viewModel = LoginViewModel()
        
        //隐藏详细表单
        hideDetailInput()
        
        initData()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }


    func hideDetailInput() {
        firstLoginCell.hidden = true
        shopNameCell.hidden = true
        userNameCell.hidden = true
        detailCell.hidden = true
        addressCell.hidden = true
        startCell.hidden = true
    }
    
    func showDetailInput() {
    
        shopNameCell.hidden = false
        userNameCell.hidden = false
        detailCell.hidden = false
        addressCell.hidden = false
        startCell.hidden = false
        
        isFirst = true
    }
    
    var viewModel: LoginViewModel? {
        didSet {
            viewModel?.loginBack.observe {
                [weak self] in
                ViewUtils.hideLoading((self?.view)!)
                
                if $0.h?.code == 200 {
                    ViewUtils.showMessage((self?.view)!, message: "登录成功")
                    UserUtils.setUserInfo($0.user!)
                    //发送通知
                    NSNotificationCenter.defaultCenter().postNotificationName("updateUser", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("loginMsg", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("getData", object: nil)
                    
                    self?.showData($0.user!)
                    
                } else if $0.h?.code == 4017 { //完善资料
                    //第一次登录
                    self?.user = User()
                    self?.firstLoginCell.hidden = false
                    self?.showDetailInput()
                    
                } else if $0.h?.code == 4025 { //验证码错误
                    ViewUtils.showMessage((self?.view)!, message: "验证码错误")
                }
            }
            
            viewModel?.getCodeBack.observe {
                [weak self] in
                
                self?.hideLoading()
            
                if $0.h?.code == 200 {
                    ViewUtils.showMessage((self?.view)!, message: "验证码发送成功")
                    self?.verBtn.setTitle("60s", forState: UIControlState.Disabled)
                    //开始倒计时 60s
                    self?.timerCounting()
                    self?.verBtn.enabled = false
                    self?.loginBtn.enabled = true
                }
            }
            
            viewModel?.complateDataBack.observe {
                [weak self] in
                
                self?.hideLoading()
                
                if $0.h?.code == 200 {
                    self?.onSubmitSuccess()
                }
                
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
    
    func onSubmitSuccess() {
        ViewUtils.showMessage((self.view)!, message: "数据提交成功")
        self.dismissViewControllerAnimated(true, completion: nil)
        UserUtils.setUserInfo(user!)
    }

    
    var isFirst: Bool = false
    var user: User?
    
    //显示用户信息
    func showData(user: User) {
        self.user = user
        showDetailInput()
        addressInput.setTitle((user.addrRes?.city)! + (user.addrRes?.area)!, forState: UIControlState.Normal)
        userNameInput.text = user.name
        shopNameInput.text = user.shopName
        detailInput.text = user.addrRes?.detail
    }
    
    func showLoading() {
        ViewUtils.showLoading(view)
    }
    
    func hideLoading() {
        ViewUtils.hideLoading(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getCode(sender: UIButton) {
        let phone = checkPhone()
        if phone == "" {
            return
        }
        ViewUtils.showLoading(view)
        viewModel?.getCodeService(phone, type: 3)
    }
    
    @IBAction func login(sender: AnyObject) {
        let phone = checkPhone()
        let code = checkCode()
        
        if phone == "" || code == "" {
            return
        }
        
        ViewUtils.showLoading(view)
        viewModel?.subVerCode(phone, code: code)
    }
    
    func checkPhone() -> String {
        let phone = phoneNum.text
        let msg = StringUtils.checkPhoneNumber(phone!)
        if msg != "" {
            ViewUtils.showMessage(self.view, message: msg)
            return ""
        }
        return phone!
    }
    
    func checkCode() -> String {
        let codeStr = verCode.text
        if codeStr == "" {
            ViewUtils.showMessage(self.view, message: "请输入验证码")
            return ""
        }
        return codeStr!
    }
    
    func startTimer() {
        second! -= 1
        verBtn.setTitle("\(second)s", forState: UIControlState.Disabled)
        if second == 0 {
            timerRunning = false
            timer.invalidate()
            
            verBtn.enabled = true
            second = COUNT
        }
    }
    
    func timerCounting() {
        if timerRunning == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LoginViewController.startTimer), userInfo: nil, repeats: true)
            timerRunning = true
        }
    }
    
    @IBAction func onCloseClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitData(sender: AnyObject) {
        let shopName = shopNameInput.text
        let userName = userNameInput.text
        let detail = detailInput.text
    
        var cityId = self.cityId
        var areaId = self.areaId
        
        if StringUtils.checkString(shopName) {
            ViewUtils.showMessage(view, message: "请输入店铺名")
            return
        }

        if StringUtils.checkString(userName) {
            ViewUtils.showMessage(view, message: "请输入用户名")
            return
        }

        if StringUtils.checkString(detail) {
            ViewUtils.showMessage(view, message: "请输入详细地址")
            return
        }

        if cityId == nil {
            if user?.addrRes == nil {
                ViewUtils.showMessage(view, message: "请选择城市")
                return
            } else {
                cityId = user?.addrRes?.cityId
            }
        }
        
        if areaId == nil {
            if user?.addrRes != nil {
                areaId = user?.addrRes?.areaId
            }
        }
        
        if !isFirst {
            if shopName != self.user?.shopName {
                user?.shopName = shopName
            } else if userName != self.user?.name {
                user?.name = userName
            } else if detail != self.user?.addrRes?.detail {
                user?.addrRes?.detail = detail
            } else if cityId != self.user?.addrRes?.cityId {
                user?.addrRes?.cityId = cityId
            } else if areaId != self.user?.addrRes?.areaId {
                user?.addrRes?.areaId = areaId
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        } else {
            user?.shopName = shopName
            user?.name = userName
            user?.addrRes?.detail = detail
            user?.addrRes?.cityId = cityId
            user?.addrRes?.areaId = areaId
        }
        
        viewModel?.completeData(user!)
    
    }
    
}

extension LoginViewController: ActionSheetCustomPickerDelegate {

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
            addressInput.setTitle(addressStr, forState: UIControlState.Normal)
        }
    }
    
    
    func calculateFirstData() {
        districtArr = []
        for jsonObj in json.array![index1]["area"].array! {
            let name = jsonObj["name"].string
            let id = jsonObj["id"].int
            
            districtIDArr.append(id!)
            districtArr.append(name!)
        }
        
    }
    
    func actionSheetPickerDidSucceed(actionSheetPicker: AbstractActionSheetPicker!, origin: AnyObject!) {
        print("test")
        
        cityId = countryIDArr[index1]
        areaId = districtIDArr[index2]
        
        addressInput.setTitle(countryArr[index1] + districtArr[index2], forState: UIControlState.Normal)
        
    }
    
    func actionSheetPickerDidCancel(actionSheetPicker: AbstractActionSheetPicker!, origin: AnyObject!) {
        print("test")
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
    
    @IBAction func onSelectCityClicked(sender: AnyObject) {
        let picker = ActionSheetCustomPicker.init(title: "选择地址", delegate: self, showCancelButton: true, origin: self.view, initialSelections: [index1, index2])
        
        picker.tapDismissAction = TapAction.Success
        
        picker.setDoneButton(UIBarButtonItem(title: "确定", style: .Plain, target: nil, action: nil))
        picker.setCancelButton(UIBarButtonItem(title: "取消", style: .Plain, target: nil, action: nil))
        
        picker.showActionSheetPicker()
        
        view.endEditing(true)
    }

}
