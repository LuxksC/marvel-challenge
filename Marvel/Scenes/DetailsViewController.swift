//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Aloc SP11602 on 02/04/22.
//

import UIKit

class DetailsViewController: UIViewController {

    static let identifier: String = "DetailsViewController"
    
    private var viewModel: DetailsViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(thumbnailImageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(eventsButton)
        
        setupConstraints()
        setupView()
    }
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .light)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    lazy var eventsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Events", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(listEvents), for: .touchUpInside)
        return button
    }()
    
    @objc
    func listEvents() {
        let eventsViewController: EventsViewController = EventsViewController(
            viewModel: EventsViewModel(name: self.viewModel.hero.name ?? "Hero Events", id: self.viewModel.hero.id ?? 0, services: EventsService()))
        navigationController?.pushViewController(eventsViewController, animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 200),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
            thumbnailImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50),
            thumbnailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            eventsButton.heightAnchor.constraint(equalToConstant: 45),
            eventsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            eventsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            eventsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupView() {
        let url = URL(string: "\(viewModel.hero.thumbnail?.path ?? "").\(viewModel.hero.thumbnail?.thumbnailExtension ?? "")")
        
        thumbnailImageView.kf.setImage(with: url)
        nameLabel.text = viewModel.hero.name
        descriptionLabel.text = viewModel.hero.description
    }
}
