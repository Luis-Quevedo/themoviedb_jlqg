//
//  UIImageView+Extension.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        // Mark: Ayuda a descargar la imagen en un background thread para evitar el bloquo de la UI y actualiza la imagen en el hilo principal
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
