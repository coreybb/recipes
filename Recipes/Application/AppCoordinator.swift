import UIKit

protocol RecipeListCoordinating: AnyObject {
    func showRecipeDetail(for recipe: Recipe)
    func showOptionsModal(from viewController: UIViewController, onSortTapped: @escaping (SortParameter) -> Void)
    func showNoRecipeData(from viewController: UIViewController)
}


final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private let dependencyContainer: DependencyContainer
    private let controllerFactory: ControllerFactory
    
    
    //  MARK: - Initialization
    init(
        navigationController: UINavigationController,
        dependencyContainer: DependencyContainer,
        controllerFactory: ControllerFactory
    ) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
        self.controllerFactory = controllerFactory
    }
    
    
    //  MARK: - Internal API
    func start() {
        showRecipeList()
    }
    
    
    func showRecipeList() {
        push(
            controllerFactory.makeRecipeListController(
                container: dependencyContainer,
                coordinator: self
            )
        )
    }
    
    
    private func push(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: false)
    }
}



//  MARK: - Recipe List Coordinating

extension AppCoordinator: RecipeListCoordinating {
    
    func showRecipeDetail(for recipe: Recipe) {
        
    }
    
    
    func showOptionsModal(from viewController: UIViewController, onSortTapped: @escaping (SortParameter) -> Void) {
        let controller = controllerFactory.makeRecipeListModalController(onSortTapped: onSortTapped)
        viewController.present(controller, animated: true)
    }
    
    
    func showNoRecipeData(from viewController: UIViewController) {
        viewController.present(controllerFactory.makeNoRecipeDataController(), animated: true)
    }
}
