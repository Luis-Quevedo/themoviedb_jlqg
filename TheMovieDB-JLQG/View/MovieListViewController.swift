//
//  MovieListViewController.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

//MARK: Aquí Configuro la UITableView, vinculo el ViewModel a la vista y manejo la lógica de navegación a la vista de detalles. También gestiono la paginación al detectar el desplazamiento al final de la tabla."

import UIKit
import Combine

class MovieListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = MovieListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        configureNavigationBar()
        view.backgroundColor = ColorFactory.green900
        /*for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  \(name)")
            }
        }*/
    }
    
    private func setupTableView() {
            
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Configurar las esquinas redondeadas
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
        ])
    }
    
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                //print("data: "+"\(data)")
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    //print("message: "+"\(message)")
                    // Show error message
                }
            }
            .store(in: &cancellables)
    }
    
    private func configureNavigationBar() {
        self.title = "Top Rated Movies"
        let textAttributes = [NSAttributedString.Key.foregroundColor: ColorFactory.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("viewModel.movies.count:"+"\(viewModel.movies.count)")
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: viewModel.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        //print("didSelectRowAt movie"+"\(movie)")
        let detailVC = MovieDetailViewController(viewModel: MovieDetailViewModel(movie: movie))
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(detailVC, animated: true)
    }
        
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if let lastMovie = viewModel.movies.last {
                viewModel.loadMoreMovies(currentItem: lastMovie)
            }
        }
    }
}
