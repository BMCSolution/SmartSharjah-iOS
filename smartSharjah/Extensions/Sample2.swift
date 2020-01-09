//
//  Sample2.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit

//
struct AppFontArabic {

    static let regular = "GESSTwoMedium-Medium"
    static let bold = "GESSTwoBold-Bold"
    static let italic = "CourierNewPS-ItalicMT"
}

struct AppFontEnglish {

    static let regular = "Calibri"
    static let bold = "Calibri-Bold"
    static let italic = "CourierNewPS-ItalicMT"
}
extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        if Utility.isArabicSelected()
        {
            return UIFont(name: AppFontArabic.regular, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        else
        {
            return UIFont(name: AppFontEnglish.regular, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        if Utility.isArabicSelected()
        {
            return UIFont(name: AppFontArabic.bold, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        else
        {
            return UIFont(name: AppFontEnglish.bold, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        if Utility.isArabicSelected()
        {
            return UIFont(name: AppFontArabic.italic, size: size)!
        }
        else
        {
            return UIFont(name: AppFontEnglish.italic, size: size)!
        }
        
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            if Utility.isArabicSelected()
            {
                fontName = AppFontArabic.regular
            }
            else
            {
                fontName = AppFontEnglish.regular
            }
            
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            if Utility.isArabicSelected()
            {
               fontName = AppFontArabic.bold
            }
            else
            {
                fontName = AppFontEnglish.bold
            }
            
        case "CTFontObliqueUsage":
            fontName = AppFontArabic.italic
        default:
           if Utility.isArabicSelected()
            {
                fontName = AppFontArabic.regular
            }
            else
            {
                fontName = AppFontEnglish.regular
            }
        }
        self.init(name: fontName, size: fontDescriptor.pointSize )!
    }

    class func overrideInitialize() {
        guard self == UIFont.self else { return }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}

extension UILabel {
    var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"-Medium") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"-Medium") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
}
extension UITextField {
    var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (15)) }
    }
}
extension UIFont {
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "GESSTwoMedium-Medium", size: size)!
    }
    class func appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "GESSTwoBold-Bold", size: size)!
    }
}


extension UILabel{
    
    func setBold()
    {
        if Utility.isArabicSelected()
        {
            self.font = UIFont(name: AppFontArabic.bold, size: self.font.pointSize)
        }
        else
        {
            self.font = UIFont(name: AppFontEnglish.bold, size: self.font.pointSize)
        }
        
      
        
    }
}
