//
//  MyCollectionViewCell.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/24.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation
class MyCollectionViewCell: UICollectionViewCell {

    var myLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        myLabel.textAlignment = NSTextAlignment.Center
        
        self.addSubview(myLabel!)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
}