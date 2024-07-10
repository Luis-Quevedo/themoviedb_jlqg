//
//  MovieDetailViewController.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 07/07/24.
//

//MARK: Cree el ViewController que contrendrá el tableView con la lista de peliuculas y se configura su Delegate y DataSource

import UIKit

class MovieDetailViewController: UIViewController {
    private let viewModel: MovieDetailViewModel
    
    private let posterImageView: UIImageView = {
        ImageFactory.imageF(contentMode: .scaleAspectFit, cornerRadius: 80.0)
    }()
            
    private let cardImageView: UIView = {
        ViewFactory.viewF(backgroundColor: ColorFactory.grey100, cornerRadius: 25)
    }()
    
    private let cardDescView: UIView = {
        ViewFactory.viewF(backgroundColor: ColorFactory.grey100, cornerRadius: 25, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner])
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        LabelFactory.labelF(font: FontFactory.medium(size: 20), textColor: ColorFactory.green900, numberOfLines: 0, textAlignment: .center)
    }()
    private let releaseDateLabel: UILabel = {
        LabelFactory.labelF(font: FontFactory.medium(size: 16), textColor: ColorFactory.green700, numberOfLines: 0, textAlignment: .center)
    }()
    private let overviewLabel: UILabel = {
        LabelFactory.labelF(font: FontFactory.regular(size: 18), textColor: ColorFactory.green800, numberOfLines: 0, textAlignment: .justified)
    }()
    private let voteAverageLabel: UILabel = {
        LabelFactory.labelF(font: FontFactory.medium(size: 17), textColor: ColorFactory.green900, numberOfLines: 1, textAlignment: .center)
    }()

    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureView()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        // Cambia el color del botón de retroceso ("< Back")
        self.navigationController?.navigationBar.tintColor = ColorFactory.grey100
        
        // Agregar botón con icono de estrella en el lado derecho
        let starButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(showDescriptionModal))
        starButton.tintColor = ColorFactory.grey100 // Cambia el color del icono si es necesario
        navigationItem.rightBarButtonItem = starButton
        
    }
        
    @objc private func showDescriptionModal() {
        let modalVC = ModalViewController(message: "Your vote has been added successfully")
        modalVC.modalPresentationStyle = .overCurrentContext
        modalVC.modalTransitionStyle = .crossDissolve
        present(modalVC, animated: true, completion: nil)
    }
    
    private func setupViews() {
        // Setup views and layout
        self.view.backgroundColor = ColorFactory.green900
        
        view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            contentView.addSubview(cardImageView)
            contentView.addSubview(cardDescView)
                            
            cardImageView.addSubview(posterImageView)
            cardImageView.addSubview(titleLabel)
            cardImageView.addSubview(releaseDateLabel)
            cardImageView.addSubview(voteAverageLabel)
            cardDescView.addSubview(overviewLabel)

        let imageHeight = view.frame.size.height/4
        let imageWidth = view.frame.size.width/2
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            posterImageView.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 25),
            posterImageView.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -10),
            posterImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            posterImageView.widthAnchor.constraint(equalToConstant: imageWidth),

            titleLabel.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 23),
            titleLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: -10),

            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            releaseDateLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 10),
            releaseDateLabel.trailingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: -10),
                                            
            voteAverageLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
            voteAverageLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 10),
            voteAverageLabel.trailingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: -10),

            posterImageView.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: -25),

            cardDescView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 20),
            cardDescView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cardDescView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cardDescView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -30),
            
            overviewLabel.topAnchor.constraint(equalTo: cardDescView.topAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: cardDescView.leadingAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: cardDescView.trailingAnchor, constant: -15),
            overviewLabel.bottomAnchor.constraint(equalTo: cardDescView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureView() {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        overviewLabel.text = viewModel.overview
        voteAverageLabel.text = viewModel.voteAverage
        if let posterURL = viewModel.posterURL {
            // Load image from URL
            posterImageView.image = nil
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterURL)")
            else { return posterImageView.image = nil }
            posterImageView.loadImage(from: url)
        } else {
            posterImageView.image = nil
        }
    }
}
