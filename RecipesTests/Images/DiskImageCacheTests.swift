import XCTest
@testable import Recipes

final class DiskImageCacheTests: XCTestCase {
    
    var sut: DiskImageCache!
    let testFileName = "test_image.png"
    
    override func setUpWithError() throws {
        sut = try DiskImageCache()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_saveAndRetrieveImage() async throws {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
        let testImage = renderer.image { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 100, height: 100))
        }
    
        try await sut.save(image: testImage, fileName: testFileName)
        let retrievedImage = try await sut.getImage(fileName: testFileName)
        

        XCTAssertNotNil(retrievedImage)
        XCTAssertEqual(testImage.pngData()!.count, retrievedImage.pngData()!.count)
    }
    
    func test_retrieveNonExistentImage() async {
        do {
            _ = try await sut.getImage(fileName: "non_existent_image.png")
            XCTFail("Expected to throw ImageError.imageNotFound")
        } catch {
            XCTAssertTrue(true, "An error was thrown as expected")
        }
    }
}
