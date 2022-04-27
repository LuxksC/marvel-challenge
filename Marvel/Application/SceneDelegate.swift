import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        
        configNavigation(navigation: navigationController)
        
        let appCoordinator = AppCoordinator(rootViewController: navigationController)
        
        appCoordinator.start()
        
        window?.rootViewController = appCoordinator.rootViewController
        
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    private func configNavigation(navigation: UINavigationController) {
        navigation.navigationBar.prefersLargeTitles = true
        
        navigation.navigationBar.tintColor = UIColor.navBarTint
        
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = UIColor.navBarBackground
        appearence.titleTextAttributes = [ .foregroundColor: UIColor.navBarTitle, .font: UIFont.navBarTitle ]
        appearence.largeTitleTextAttributes = [ .foregroundColor: UIColor.navBarTitle, .font: UIFont.navBarLargeTitle]
        
        navigation.navigationBar.standardAppearance = appearence
        navigation.navigationBar.scrollEdgeAppearance = appearence
    }
    
}

