import UIKit

class HomeViewController: UIViewController {

	fileprivate enum ViewState {
	  case loading
	  case normal
	  case error
	}
	
	fileprivate var state: ViewState = .normal {
	  didSet {
		self.setupView()
	  }
	}
	
	internal var viewModel: HeroViewModel
    
    private var loading = UIActivityIndicatorView(style: .large)
    
    // estilização da collection
    lazy var collectionview: UICollectionView = {
        let windowWidth = view.frame.size.width
        let cardWidth = ( windowWidth - 16 - 32 ) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cardWidth, height: 300)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.bg
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        return collection
    }()
    
    init (viewModel: HeroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        configNavigation()
        
        configCollection()
        
        configLoadingIndicator()
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.delegate = self
        
		state = .loading
        showLoadingIndicator()
		fetchHero()
	}
    
    // MARK: - Private methods
	
	private func fetchHero() {
		viewModel.fetchHero()
	}
	
	private func setupView() {
		
        switch state {
        case .loading:
            print("loading")
        case .normal:
            print("normal")
            DispatchQueue.main.async {
                self.collectionview.reloadData()
            }
        case .error:
            print("error")
        }
        
        self.hideLoadingIndicator()
        
	}
    
    private func configNavigation() {
        title = "Heroes"
    }
    
    private func configCollection() {
        view.addSubview(collectionview)
        
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: view.topAnchor),
            collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configLoadingIndicator() {
        loading.color = .systemRed
        loading.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    private func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.loading.startAnimating()
            self.loading.isHidden = false
        }
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            self.loading.isHidden = true
        }
    }
}

extension HomeViewController: HeroViewModelDelegate {
	func heroFetchWithSucess() {
		state = .normal
	}
	
	func errorToFetchHero(_ error: String) {
		
		print(error)
		state = .error
	}
	
	
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {return UICollectionViewCell()}
        
        guard let hero = viewModel.heroes?[indexPath.row] else { return UICollectionViewCell() }
        
        cell.setCellData(with: hero)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hero = viewModel.heroes?[indexPath.row] else { return }
        viewModel.didSelectHero(hero: hero)
    }
    
    
}
