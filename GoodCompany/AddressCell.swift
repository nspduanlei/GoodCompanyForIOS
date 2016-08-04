//
//  AddressCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/8.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class AddressCell: UITableViewCell {
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var defaultBtn: UIButton!
    @IBOutlet weak var addressDetail: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var address: GoodsReceipt!
    var context: ManagerAddressController?
    
    func initUi(address: GoodsReceipt, context: ManagerAddressController) {
        
        self.address = address
        self.context = context
        
        phoneNum.text = address.phone
        userName.text = address.name
        addressDetail.text = (address.addrRes?.city)! + (address.addrRes?.area)! + (address.addrRes?.detail)!

        defaultBtn.selected = address.isDefault!
        
        if let isDefault = address.isDefault {
            if isDefault {
               deleteBtn.hidden = true
            }
        }
    }
    
    @IBAction func onDeleteClicked(sender: AnyObject) {
        context?.delAddress((address?.addressId)!)
        
    }
    
    @IBAction func onEditClicked(sender: AnyObject) {
        
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("managerAddress") as! AddressDetailViewController
        
        vc.address = self.address.getAddressPost()
        
        context!.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func onDefaultClicked(sender: AnyObject) {
        if let isDefault = address.isDefault {
            
            if !isDefault {
                context?.setDefaultAddress((address?.addressId)!)
            }
            
        }
    }
    


    
    
    

}