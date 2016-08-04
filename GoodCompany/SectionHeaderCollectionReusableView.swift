//
//  SectionHeaderCollectionReusableView.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/24.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    
    var headerLable: UILabel!
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        headerLable = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        self.addSubview(headerLable)
    }

}