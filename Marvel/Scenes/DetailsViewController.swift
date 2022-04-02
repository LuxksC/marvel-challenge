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
//        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFit
//        image.tintColor = .systemGray
        image.layer.cornerRadius = 10
//        image.backgroundColor = .cyan
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .light)
        label.textColor = .black
        label.text = "Hero"
        return label
    }()
    
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
    }
    
    func setupView() {
        let url = URL(string: "\(viewModel.hero.thumbnail?.path ?? "").\(viewModel.hero.thumbnail?.thumbnailExtension ?? "")")
        
        thumbnailImageView.kf.setImage(with: url)
        nameLabel.text = viewModel.hero.name
    }
}
