//
//  UILabelDeviceClass.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class UILabelDeviceClass: UILabel {

    @IBInspectable var iPhoneFontSize:CGFloat = 0 {
        didSet {
            overrideFontSize(fontSize: iPhoneFontSize)
        }
    }
   
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    func overrideFontSize(fontSize:CGFloat) {
        
        let currentFontName = self.font.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize)
            self.font = calculatedFont
            break
        case 568.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize)
            self.font = calculatedFont
            break
        case 667.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 2)
            self.font = calculatedFont
            break
        case 736.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 2)
            self.font = calculatedFont
            break
        case 812.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 3)
            self.font = calculatedFont
            break
        case 896.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 3)
            self.font = calculatedFont
            break
        default:
            print("not an iPhone")
            break
        }
    }
}
