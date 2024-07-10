//
//  MovieListViewModel.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

//MARK: Aquí manejo la lógica de negocio para la vista de la lista de películas. Uso Combine para publicar cambios en los datos y gestionar el estado de la carga. La paginación la implemento aquí para cargar más películas cuando el usuario llega al final de la lista

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var currentPage = 1
    private var cancellable: AnyCancellable?
    private let movieService = MovieService()
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies() {
        //print("fetchMovies")
        isLoading = true
        cancellable = movieService.fetchTopRatedMovies(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] movies in
                //print("fetchMovies movies: " + "\(movies)")
                //Mark: Ordeno las películas por `voteAverage` en orden descendente y limito las peliculas a las primeras 10.
                self?.movies.append(contentsOf: movies)
                self?.currentPage += 1                
            })
    }
        
    func loadMoreMovies(currentItem: Movie) {
        if movies.last == currentItem && !isLoading {
            fetchMovies()
        }
    }
}
