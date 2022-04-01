//
//  ViewController.swift
//  Marvel
//
//  Created by Douglas Nunes on 30/03/22.
//

import UIKit

class ViewController: UIViewController {

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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel?.delegate = self
		
		view.backgroundColor = .white
	
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
			
			print(viewModel?.hero?.data?.results?[0].name ?? "")
		case .error:
			print("error")
		}
		
	}
}

extension ViewController: HeroViewModelDelegate {
	func heroFetchWithSucess() {
		state = .normal
	}
	
	func errorToFetchHero(_ error: String) {
		
		print(error)
		state = .error
	}
	
	
}
