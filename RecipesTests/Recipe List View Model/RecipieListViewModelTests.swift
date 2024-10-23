import XCTest
@testable import Recipes

final class RecipeListViewModelTests: XCTestCase {
    
    var sut: RecipeListViewModel!
    var mockRepository: MockRecipeRepository!
    var mockFetchImageUseCase: MockFetchImageUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockRecipeRepository()
        mockFetchImageUseCase = MockFetchImageUseCase()
        sut = RecipeListViewModel(
            repository: mockRepository,
            fetchImageUseCase: mockFetchImageUseCase
        )
    }

    func testSearchRecipes() {
        let recipes = [
            Recipe.mock(cuisine: .italian, name: "Pasta"),
            Recipe.mock(cuisine: .british, name: "Sushi"),
            Recipe.mock(cuisine: .polish, name: "Tacos")
        ]
        sut.recipeCellViewModels = recipes.map {
            RecipeCellViewModel(
                recipe: $0,
                fetchImageUseCase: mockFetchImageUseCase
            )
        }
        sut.displayedRecipeCellViewModels = sut.recipeCellViewModels
        sut.searchRecipes(for: "Pasta")
        
        XCTAssertEqual(sut.displayedRecipeCellViewModels.count, 1)
        XCTAssertEqual(sut.displayedRecipeCellViewModels.first?.name, "Pasta")
    }

}
