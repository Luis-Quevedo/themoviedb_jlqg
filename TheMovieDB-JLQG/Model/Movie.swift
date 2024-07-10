//
//  Movie.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

//MARK: Este modelo lo utilizo para mapear los datos recibidos de la API de TMDb, usando Decodable para facilitar la deserialización de JSON.

import Foundation

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    // MARK: Se conforma el struct Movie al protocolo Equatable para permitir la comparación de instancias. Esto es necesario para la funcionalidad de paginación en loadMoreMovies
        static func == (lhs: Movie, rhs: Movie) -> Bool {
            return lhs.id == rhs.id
        }
}

