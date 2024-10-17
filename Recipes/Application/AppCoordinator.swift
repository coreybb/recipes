import UIKit

protocol RecipeListCoordinating: AnyObject {
    func showRecipeDetail(for recipe: Recipe)
}


final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private let dependencyContainer: DependencyContainer
    
    
    //  MARK: - Initialization
    init(
        navigationController: UINavigationController,
        dependencyContainer: DependencyContainer
    ) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    
    //  MARK: - Internal API
    func start() {
        showRecipeList()
    }
    
    
    func showRecipeList() {
        let recipeListController = RecipeListController(container: dependencyContainer)
        recipeListController.coordinator = self
        push(recipeListController)
    }
    
    
    private func push(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: false)
    }
}



//  MARK: - Recipe List Coordinating
extension AppCoordinator: RecipeListCoordinating {
    
    func showRecipeDetail(for recipe: Recipe) {
        print("showing detail for \(recipe.name)")
    }
}
