//
//  MovieDetailViewModel.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//


//MARK: Aquí encapsulo la lógica necesaria para mostrar los detalles de la película, proporcionando propiedades calculadas para formatear los datos correctamente.

import Foundation

class MovieDetailViewModel {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var releaseDate: String {
        return movie.releaseDate
    }
    
    var overview: String {
        return movie.overview
    }
    
    var voteAverage: String {
        return "\(movie.voteAverage)"
    }
    
    var posterURL: URL? {
        if let posterPath = movie.posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil
    }
}

