import UIKit

class AppCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinators: [CoordinatorBase] = []
    
    var rootViewController: UINavigationController
    
    required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        
        let homeCoordinator = HomeCoordinator(rootViewController: rootViewController)
        
        childCoordinators.append(homeCoordinator)
        
        homeCoordinator.start()
    }
    
    
}
