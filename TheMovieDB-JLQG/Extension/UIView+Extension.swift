//
//  UIView+Extension.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 10/07/24.
//

import UIKit

extension UIView {
    func addShadow(offset:CGSize, color:UIColor, radius:CGFloat, opacity:Float) {
        layer.cornerRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
    }
    
    func addCornerRadius(radius: CGFloat){
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addCornerRadius(corners:CACornerMask, radius: CGFloat) {
        
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
    
}
