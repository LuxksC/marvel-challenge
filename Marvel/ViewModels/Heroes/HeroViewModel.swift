import Foundation

class HeroViewModel {
	
	private var services: HeroListServiceProtocol
	
	weak var delegate: HeroViewModelDelegate?
	
	var heroes: [Hero]?
    
    var coordinator: HomeCoordinator
	
    init(services: HeroListServiceProtocol, coordinator: HomeCoordinator) {
		self.services = services
        self.coordinator = coordinator
	}
	
	func fetchHero() {
		
		services.execute { result in
			
			switch result {
			case .success(let response):
				self.sucess(response: response)
			case .failure(let error):
				self.error(error: error.localizedDescription)
			}
		}
	}
	
    func didSelectHero(hero: Hero) {
        coordinator.pushHeroDetailsViewController(hero: hero)
    }
    
    private func sucess(response: Response) {
        self.heroes = response.data?.results
		delegate?.heroFetchWithSucess()
	}
	
	private func error(error: String) {
		delegate?.errorToFetchHero(error)
	}
}
