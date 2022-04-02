//
//  ViewController.swift
//  Marvel
//
//  Created by Douglas Nunes on 30/03/22.
//

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
	
	internal var viewModel: HeroViewModel?
    
    // estilização da collection
    lazy var collectionview: UICollectionView = {
        let windowWidth = view.frame.size.width
        let cardWidth = ( windowWidth - 16 - 32 ) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cardWidth, height: 200)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .red
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    
    override func loadView() {
        super.loadView()
        
        configNavigation()
        
        configCollection()
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel?.delegate = self
		
		view.backgroundColor = .systemBackground
	
		state = .loading
		
		fetchHero()
	}
    
    // MARK: - Private methods
	
	private func fetchHero() {
		viewModel?.fetchHero()
	}
	
	private func setupView() {
		
        switch state {
        case .loading:
            print("loading")
        case .normal:
            print("normal")
// -------- API REFERENCES --------------
//            for item in viewModel!.heroes ?? [] {
//                print(item.name!)
//                print("\(item.thumbnail?.path ?? "").\(item.thumbnail?.thumbnailExtension ?? "")")
//            }
// -------- API REFERENCES --------------
            DispatchQueue.main.async {
                self.collectionview.reloadData()
            }
        case .error:
            print("error")
        }
        
	}
    
    private func configNavigation() {
        title = "Heroes"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configCollection() {
        view.addSubview(collectionview)
        
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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
        return viewModel!.heroes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .blue
        
        //let hero = viewModel!.heroes![indexPath.row]
        
        //cell.setup(hero)
        
        return cell
    }
    
    
}
