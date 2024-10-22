import UIKit

final class ControllerFactory {
    
    func makeRecipeListController(
        container: DependencyContainer,
        coordinator: RecipeListCoordinating
    ) -> RecipeListController {
        let controller = RecipeListController(container: container)
        controller.coordinator = coordinator
        return controller
    }
    
    
    func makeRecipeListModalController(onSortTapped: @escaping (SortParameter) -> Void) -> RecipeListModalController {
        let controller = RecipeListModalController()
        if let presentationController = controller.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        controller.onSortTapped = onSortTapped
        controller.view.layer.cornerRadius = 24
        return controller
    }
    
    
    func makeNoRecipeDataController() -> NoRecipeDataController {
        NoRecipeDataController()
    }
}
