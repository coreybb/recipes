import Foundation


enum ConfigurationConstant {
    case apiBaseURL
}


extension ConfigurationConstant {
    var key: String {
        switch self {
        case .apiBaseURL:
            "API_BASE_URL"
        }
    }
    
    var value: String {
        guard let value: String = try? Configuration.value(for: key) else {
            fatalError("\(key) is not set in the project's info.plist.")
        }
        
        return value
    }
}


// From NSHipster: https://nshipster.com/xcconfig/
enum Configuration {

    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        
        guard let object: Any = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T: return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default: throw Error.invalidValue
        }
    }
}
