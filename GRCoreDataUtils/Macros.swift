//
//  GRLogger.swift
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Revilo on 14/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import Foundation
import UIKit


#if DEBUG
    func DLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
    }
    
    func ULog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    let alertView = UIAlertView(title: "[\(filename.lastPathComponent):\(line)]", message: "\(function) - \(message)",  delegate:nil, cancelButtonTitle:"OK")
    alertView.show()
    }
    
#else
    func DLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) { }
    
    func ULog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) { }
    
#endif
