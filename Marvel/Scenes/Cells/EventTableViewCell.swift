import UIKit
import Kingfisher

class EventTableViewCell: UITableViewCell {

    static let identifier: String = "EventTableViewCell"
    
    lazy var eventImageView: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "photo.circle")
        picture.contentMode = .scaleAspectFit
        picture.translatesAutoresizingMaskIntoConstraints = false
        return picture
    }()
    
    lazy var eventNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(eventImageView)
        
        NSLayoutConstraint.activate([
            eventImageView.widthAnchor.constraint(equalToConstant: 140),
            eventImageView.heightAnchor.constraint(equalToConstant: 140),
            eventImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            eventImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(eventNameLabel)
        
        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10),
            eventNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            eventNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            eventNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCellData(with event: Event, rowNumber: Int) {
        
        let url = URL(string: "\(event.thumbnail?.path ?? "").\(event.thumbnail?.thumbnailExtension ?? "")")
        eventImageView.kf.setImage(with: url)
        eventNameLabel.text = "\(rowNumber)- \(event.title ?? "Evento Desconhecido")"
    }

}
