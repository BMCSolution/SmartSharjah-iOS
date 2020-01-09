//
//  Date+Extension.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    //let isEqual = date1.isEqualTo(date2)
//    let date1 = Date()
//    let date2 = Date()
//    
//    let isGreater = date1 > date2
//    print(isGreater)
//    
//    let isSmaller = date1 < date2
//    print(isSmaller)
//    
//    let isEqual = date1 == date2
//    print(isEqual)
    
    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
    
    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    func isSmallerThan(_ date: Date) -> Bool {
        return self < date
    }
}
