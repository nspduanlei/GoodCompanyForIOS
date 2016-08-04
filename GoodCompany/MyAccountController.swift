//
//  MyAccountController.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/24.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
import UIKit

class MyAccountController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!

    var user: User!
    
    var imagePC: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.translucent = false
        //消除多余的分割线
        tableView.tableFooterView = UIView()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        //如果没有登录，跳转到登录
        if UserUtils.getToken() == nil {
            let sb = UIStoryboard(name:"Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("login")
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            user = UserUtils.getUserInfo()
            bindUser()
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImagePNGRepresentation(image)
    
        UserUtils.setImage(data!)

        imageHeader.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("updateUser", object: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            //本地图片选择
            imagePC = UIImagePickerController()
            imagePC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePC.delegate = self
            
            presentViewController(imagePC, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            ViewUtils.gotoView(self, id: "editData")
        }
    }
    
    func bindUser() {
        shopName.text = user.shopName
//        userName.text = user.name
//        phoneNumber.text = user.phone
        
        if let dataImage = UserUtils.getImage() {
            let imageN = UIImage(data: dataImage)
            imageHeader.image = imageN
        } else {
            imageHeader.image = UIImage(named: "default_header")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func close() {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        close()
    }
}