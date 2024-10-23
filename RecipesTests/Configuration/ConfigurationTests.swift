import XCTest
@testable import Recipes


final class ConfigurationTests: XCTestCase {
    
    func test_valueForKeyReturnsExpectedValue() throws {
        let key = "API_BASE_URL"
        let expectedValue = "https://test.api.com"
        let mockInfoDict = [key: expectedValue]
        let mockBundle = MockBundle(infoDictionaryData: mockInfoDict)
        
        let actualValue: String = try Configuration.value(for: key, in: mockBundle)
        
        XCTAssertEqual(actualValue, expectedValue)
    }
}
