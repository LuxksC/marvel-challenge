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
        let collection = UICollectionView()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel?.delegate = self
        
        title = "Home"
		
		view.backgroundColor = .orange
	
		state = .loading
		
		fetchHero()
	}
	
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
        case .error:
            print("error")
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
