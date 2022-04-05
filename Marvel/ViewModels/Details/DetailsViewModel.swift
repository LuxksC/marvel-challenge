
class DetailsViewModel {
    
    private(set) var hero: Hero
    
    var coordinator: DetailsCoordinator
    
    init(hero: Hero, coordinator: DetailsCoordinator) {
        self.hero = hero
        self.coordinator = coordinator
    }
    
    func listEvents() {
        coordinator.pushEventsViewController(hero: hero)
    }
}
