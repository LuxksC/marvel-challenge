//
//  HomeCollectionViewCell.swift
//  Marvel
//
//  Created by Aloc SP11602 on 01/04/22.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCollectionViewCell"

        lazy var thumbnailImageView: UIImageView = {
            let picture = UIImageView()
            picture.contentMode = .scaleAspectFit
            picture.translatesAutoresizingMaskIntoConstraints = false
            return picture
        }()
        
        lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
            addSubview(thumbnailImageView)
            
            NSLayoutConstraint.activate([
                thumbnailImageView.widthAnchor.constraint(equalToConstant: 140),
                thumbnailImageView.heightAnchor.constraint(equalToConstant: 140),
                thumbnailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
            addSubview(nameLabel)
            
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func getCellData(with hero: ResultHero) {
            let url = URL(string: "\(hero.thumbnail?.path ?? "").\(hero.thumbnail?.thumbnailExtension ?? "")")
            thumbnailImageView.kf.setImage(with: url)
            nameLabel.text = hero.name
        }
}
