//
//  UiView+Extension.swift
//  smartSharjah
//
//  Created by OzzY on 8/24/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //view.roundCorners([.topLeft, .bottomRight], radius: 10)
    //self.roundCorners([.topLeft, .bottomLeft], radius: 10)
    //
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

extension UIView{
   func flipView(){
       self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
   }
}
