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

    
    func value(in bundle: Bundle = .main) -> String {
        guard let value: String = try? Configuration.value(for: key, in: bundle) else {
            #if DEBUG
            fatalError("\(key) is not set in the project's info.plist.")
            #else
            return ""
            #endif
        }
        
        return value
    }
}


protocol ConfigurationValueProviding {
    static func value<T>(for key: String, in bundle: BundleProtocol) throws -> T where T: LosslessStringConvertible
}


// From NSHipster: https://nshipster.com/xcconfig/
enum Configuration {

    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
}


extension Configuration: ConfigurationValueProviding {
    
    static func value<T>(for key: String, in bundle: BundleProtocol) throws -> T where T: LosslessStringConvertible {
        
        guard let object: Any = bundle.object(forInfoDictionaryKey: key) else {
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



protocol BundleProtocol {
    func object(forInfoDictionaryKey key: String) -> Any?
}

extension Bundle: BundleProtocol { }
