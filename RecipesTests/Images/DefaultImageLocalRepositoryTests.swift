import XCTest
@testable import Recipes
import UIKit

@MainActor
final class DefaultImageLocalRepositoryTests: XCTestCase {
    
    var sut: DefaultImageLocalRepository!
    let testImage = UIImage(systemName: "star")!
    let testURL = URL(string: "https://example.com/test_image.png")!
    
    override func setUpWithError() throws {
        sut = DefaultImageLocalRepository()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_saveAndRetrieveImage() async throws {
        
        try await sut.saveImage(testImage, forURL: testURL)
        let retrievedImage = try await sut.getImage(forURL: testURL)
        
        XCTAssertNotNil(retrievedImage)
        XCTAssertEqual(retrievedImage.pngData(), testImage.pngData())
    }
    
    func test_retrieveNonExistentImage() async {
        do {
            _ = try await sut.getImage(forURL: URL(string: "https://test.com/non_existent.png")!)
            XCTFail("Expected to throw ImageError.imageNotFound")
        } catch let error as ImageError {
            XCTAssertEqual(error, .imageNotFound)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
    
    func test_saveToMemoryCache() async throws {
        await sut.saveImageToMemoryCache(testImage, url: testURL)
        let retrievedImage = try await sut.getImage(forURL: testURL)
        
        XCTAssertNotNil(retrievedImage)
        XCTAssertEqual(retrievedImage.pngData(), testImage.pngData())
    }
}
