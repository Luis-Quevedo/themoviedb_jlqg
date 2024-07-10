//
//  ModalViewController.swift
//  TheMovieDB-JLQG
//
//  Created by José Luis Quevedo on 09/07/24.
//

//MARK: Cree un modal paa mostrar el mesaje de exito cuando se presiona el boton de star en MovieDetailViewController

import UIKit

class ModalViewController: UIViewController {
    private let message: String
    
    private let modalView: UIView = {
        ViewFactory.viewF(backgroundColor: ColorFactory.grey100, cornerRadius: 10)
    }()
    
    private let titleLabel: UILabel = {
        LabelFactory.labelF(text: "Message", font: FontFactory.medium(size: 18), textColor: ColorFactory.green900, numberOfLines: 0, textAlignment: .center)
    }()
    
    private let messageLabel: UILabel = {        
        LabelFactory.labelF(font: FontFactory.regular(size: 16), textColor: ColorFactory.green800, numberOfLines: 0, textAlignment: .center)
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorFactory.green900
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(modalView)
        modalView.addSubview(titleLabel)
        modalView.addSubview(messageLabel)
        modalView.addSubview(closeButton)
        
        messageLabel.text = message
        
        NSLayoutConstraint.activate([
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            modalView.widthAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -30),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func closeModal() {
        dismiss(animated: true, completion: nil)
    }
}
