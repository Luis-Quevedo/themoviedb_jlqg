//
//  ViewFactory.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 09/07/24.
//

import UIKit

struct ViewFactory {
    
    static func viewF(backgroundColor: UIColor, cornerRadius:CGFloat, maskedCorners: CACornerMask? = nil) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let mCorner = maskedCorners {
            view.layer.maskedCorners = mCorner//[.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        }
        
        return view
    }
    
}
