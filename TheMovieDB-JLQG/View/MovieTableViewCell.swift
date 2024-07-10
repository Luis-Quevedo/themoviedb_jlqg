//
//  MovieTableViewCell.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

//MARK: Se configura los views que va a contener el UITableViewCell y proporciono un método para configurar la celda con los datos de una película.

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    private let movieImageView : UIImageView = {
        ImageFactory.imageF(contentMode: .scaleAspectFill, cornerRadius: 20.0)
    }()
    
    private let titleLabel : UILabel = {
        LabelFactory.labelF(font: FontFactory.medium(size: 20), textColor: ColorFactory.green900, numberOfLines: 0, textAlignment: .left)
    }()
    
    private let releaseDateLabel : UILabel = {                
        LabelFactory.labelF(font: FontFactory.medium(size: 16), textColor: ColorFactory.green700, numberOfLines: 0, textAlignment: .left)
    }()
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        //print("setupViews")
        // Se agregan subviews al contentView de la celda, se configura el diseño y los constraints que tendrán los elementos dentro de la celda
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
                                
        backgroundColor = ColorFactory.grey100
        
        // Establecer constraints NSLayoutConstraint.activate
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               movieImageView.widthAnchor.constraint(equalToConstant: 80),
        //movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.0),
            movieImageView.heightAnchor.constraint(equalToConstant: 70),            
            
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            //contentView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = ColorFactory.green500
        self.selectedBackgroundView = selectedBackgroundView
                
    }
    
     func configure(with movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        if let posterPath = movie.posterPath {
            movieImageView.image = nil
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
                return movieImageView.image = nil }
            movieImageView.loadImage(from: url)
        } else {
            movieImageView.image = nil
        }
    }
}


