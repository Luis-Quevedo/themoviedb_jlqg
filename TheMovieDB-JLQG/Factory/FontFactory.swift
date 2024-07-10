//
//  Fonts.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

import UIKit

struct FontFactory {
        
    static func regular(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func medium(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func light(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    
    
    
}
