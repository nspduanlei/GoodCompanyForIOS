//
//  ClidViewControllerDelegate.swift
//  GoodCompany
//
//  Created by 段磊 on 16/5/31.
//  Copyright © 2016年 段磊. All rights reserved.
//

import Foundation

protocol ChildViewControllerDelegate {
    func childViewControllerResponse(parameter: Dictionary<String, AnyObject>)
}
