//
//  Constants.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

import UIKit

struct LabelFactory {
    
    static func labelF(text: String? = nil,
                       font: UIFont,
                       backgrundColor: UIColor = .clear,
                       textColor: UIColor,
                       numberOfLines: Int,
                       textAlignment: NSTextAlignment) -> UILabel {
    
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgrundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        return label
    }
    
}
