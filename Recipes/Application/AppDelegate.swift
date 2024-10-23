import UIKit

//  MARK: - App Lifecycle
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let dependencyContainer = DependencyContainer()
    private let controllerFactory = ViewControllerFactory()
    private var coordinator: Coordinator?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
}



//  MARK: - Private API

fileprivate extension AppDelegate {
    
    private func setupWindow() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = rootController()
    }
    
    
    private func rootController() -> UIViewController {
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        
        coordinator = AppCoordinator(
            navigationController: navigationController,
            dependencyContainer: dependencyContainer,
            controllerFactory: controllerFactory
        )
        coordinator?.start()
        
        return navigationController
    }
}
