import Foundation
@testable import Recipes


final class MockNetworkDataTransport: NetworkDataTransporting {
    
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToThrow: Error?
    
    func sendRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        
        if let error = errorToThrow {
            throw error
        }
        
        let data = dataToReturn ?? Data()
        let response = responseToReturn ?? HTTPURLResponse(
            url: request.url!,
            statusCode: 200, // Use a 200 status code for OK
            httpVersion: nil,
            headerFields: nil
        )!
        
        return (data, response)
    }
}
