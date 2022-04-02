import Foundation

class HeroViewModel {
	
	private var services: HeroListServiceProtocol
	
	weak var delegate: HeroViewModelDelegate?
	
	var heroes: [ResultHero]?
	
	init(services: HeroListServiceProtocol) {
		self.services = services
	}
	
	func fetchHero() {
		
		services.execute { result in
			
			switch result {
			case .success(let hero):
				self.sucess(hero: hero)
			case .failure(let error):
				self.error(error: error.localizedDescription)
			}
		}
	}
	
	private func sucess(hero: Hero) {
		self.heroes = hero.data?.results
		delegate?.heroFetchWithSucess()
	}
	
	private func error(error: String) {
		delegate?.errorToFetchHero(error)
	}
}
