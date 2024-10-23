@testable import Recipes

final class MockBundle: BundleProtocol {
    
    private let infoDictionaryData: [String: Any]
    
    init(infoDictionaryData: [String: Any]) {
        self.infoDictionaryData = infoDictionaryData
    }
    
    func object(forInfoDictionaryKey key: String) -> Any? {
        infoDictionaryData[key]
    }
}
