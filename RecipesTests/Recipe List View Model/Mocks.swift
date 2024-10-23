import XCTest
@testable import Recipes

final class MockRecipeRepository: RecipeRepository {
    var recipesToReturn: [Recipe] = []
    var errorToThrow: Error?
    
    func fetchRecipes() async throws -> [Recipe] {
        if let error = errorToThrow {
            throw error
        }
        return recipesToReturn
    }
}

final class MockFetchImageUseCase: FetchImageUseCase {
    var imageToReturn: UIImage?
    var errorToThrow: Error?
    
    func execute(forURL url: URL) async throws -> UIImage {
        if let error = errorToThrow {
            throw error
        }
        return imageToReturn ?? UIImage()
    }
}


extension Recipe {
    static func mock(
        cuisine: Cuisine = .italian,
        name: String = "Mock Recipe",
        photoURLLarge: String = "https://test.com/large.jpg",
        photoURLSmall: String = "https://tst.com/small.jpg",
        sourceURL: String? = nil,
        id: String = "mock-id",
        youtubeURL: String? = nil
    ) -> Recipe {
        Recipe(
            cuisine: cuisine,
            name: name,
            photoURLLarge: photoURLLarge,
            photoURLSmall: photoURLSmall,
            sourceURL: sourceURL,
            id: id,
            youtubeURL: youtubeURL
        )
    }
}


enum MockError: Error {
    case testError
}
