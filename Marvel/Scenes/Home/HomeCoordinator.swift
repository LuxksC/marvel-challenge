import UIKit

final class HomeCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = HeroViewModel(services: HeroListService(), coordinator: self)
        
        let viewController = HeroesViewController(viewModel: viewModel)
        
        viewController.title = "Heroes"
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
    func pushHeroDetailsViewController(hero: Hero) {
        let detailsCoordinator = DetailsCoordinator(rootViewController: rootViewController)
        detailsCoordinator.hero = hero
        childCoordinators.append(detailsCoordinator)
        detailsCoordinator.start()
    }
}
