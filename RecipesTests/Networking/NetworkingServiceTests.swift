import XCTest
@testable import Recipes


final class NetworkingServiceTests: XCTestCase {
    
    func test_networkingService_successfulResponse() async throws {
        
        let expectedData = Data("Success".utf8)
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let mockTransport = MockNetworkDataTransport()
        mockTransport.dataToReturn = expectedData
        mockTransport.responseToReturn = expectedResponse
        
        let service = NetworkingService(networkClient: mockTransport)
        let request = URLRequest(url: URL(string: "https://test.com")!)
        let (data, response) = try await service.networkClient.sendRequest(request)
 
        XCTAssertEqual(data, expectedData)
        XCTAssertEqual(response.url, expectedResponse?.url)
        XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, expectedResponse?.statusCode)
    }
    
    
    func test_networkingService_networkError() async {
        
        let expectedError = URLError(.notConnectedToInternet)
        
        let mockTransport = MockNetworkDataTransport()
        mockTransport.errorToThrow = expectedError
        
        let service = NetworkingService(networkClient: mockTransport)
        let request = URLRequest(url: URL(string: "https://test.com")!)
        
        do {
            _ = try await service.networkClient.sendRequest(request)
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertEqual(error as? URLError, expectedError, "Error thrown does not match expected error.")
        }
    }
    
    

}
