import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let networkingService = NetworkingService(networkClient: URLSession.shared)

    
    //  MARK: - App Lifecycle
    
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
        let controller = RecipesController()
        return controller
    }
}
