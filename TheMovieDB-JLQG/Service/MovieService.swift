//
//  MovieService.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

//MARK: Aquí utilizo URLSession para hacer las solicitudes de red nativas. Empleo Combine para manejar la asincronía y la reactividad de las respuestas"


import Foundation
import Combine

class MovieService {
    private let apiKey = "774a6a703275fec76ab942bfad75891d"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchTopRatedMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        let url = URL(string: "\(baseURL)/movie/top_rated?api_key=\(apiKey)&page=\(page)")!
        
        //print("url fetchTopRatedMovies"+String(describing: url))
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
