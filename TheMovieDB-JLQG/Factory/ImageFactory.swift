//
//  ImageFactory.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 09/07/24.
//

import UIKit

struct ImageFactory {
    
    static func imageF(contentMode: UIView.ContentMode, cornerRadius:CGFloat) -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = contentMode
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        
        return view
    }
    
}
