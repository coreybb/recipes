import XCTest
@testable import Recipes

final class DefaultRecipesRemoteRepositoryTests: XCTestCase {
    
    func testFetchRecipes_DecodingError() async {
        
        let invalidJSON = Data("Invalid JSON".utf8)
        
        let mockTransport = MockNetworkDataTransport()
        mockTransport.dataToReturn = invalidJSON
        
        let networkingService = NetworkingService(networkClient: mockTransport)
        let repository = DefaultRecipesRemoteRepository(networkingService: networkingService)
        
        do {
            _ = try await repository.fetchRecipes()
            XCTFail("Expected DecodingError but got success")
        } catch {
            XCTAssertTrue(error is DecodingError, "Expected DecodingError, got \(type(of: error)): \(error)")
        }
    }
    
    
    func test_fetchRecipes_Success() async throws {
        
        let jsonData = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Boiled Fish on Toast",
                    "photo_url_large": "https://example.com/spaghetti_large.jpg",
                    "photo_url_small": "https://example.com/spaghetti_small.jpg",
                    "source_url": "https://example.com/spaghetti_recipe",
                    "uuid": "12345",
                    "youtube_url": "https://youtube.com/spaghetti_video"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let mockTransport = MockNetworkDataTransport()
        mockTransport.dataToReturn = jsonData
        
        let networkingService = NetworkingService(networkClient: mockTransport)
        let repository = DefaultRecipesRemoteRepository(networkingService: networkingService)
        let recipes = try await repository.fetchRecipes()
        
        XCTAssertEqual(recipes.count, 1)
        let recipe = recipes.first!
        XCTAssertEqual(recipe.name, "Boiled Fish on Toast")
        XCTAssertEqual(recipe.cuisine.rawValue, "British")
    }
    
    
    func test_fetchRecipes_HTTPError() async {

        let mockTransport = MockNetworkDataTransport()
        mockTransport.dataToReturn = Data()
        mockTransport.responseToReturn = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        
        let networkingService = NetworkingService(networkClient: mockTransport)
        let repository = DefaultRecipesRemoteRepository(networkingService: networkingService)
        

        do {
            _ = try await repository.fetchRecipes()
            XCTFail("Expected NetworkError.httpError but got success")
        } catch let error as NetworkError {
            if case let .httpError(statusCode) = error {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("Expected NetworkError.httpError, got \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError.httpError, got \(type(of: error))")
        }
    }
}
