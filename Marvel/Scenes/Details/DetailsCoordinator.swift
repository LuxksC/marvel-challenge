import UIKit

final class DetailsCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    var hero: Hero?
    
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = DetailsViewModel(hero: hero!, coordinator: self)
        
        let viewController = DetailsViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func pushEventsViewController(hero: Hero) {
        let viewModel = EventsViewModel(name: hero.name!, id: hero.id!, services: EventsService())
        
        let viewController = EventsViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}
