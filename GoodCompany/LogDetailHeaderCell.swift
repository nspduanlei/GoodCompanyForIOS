//
//  LogDetailHeaderCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/7/26.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class LogDetailHeaderCell: UITableViewCell {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var driver: UILabel!

    func initUi(data: TransportItem) {
        number.text = data.trackingNumber
        phone.text = data.phone
        company.text = data.supplierName
        driver.text = data.name
    }
}