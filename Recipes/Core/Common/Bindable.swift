import Foundation
import Combine

protocol Bindable: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
    func subscribe<P: Publisher>(
        _ publisher: P,
        receiveOn scheduler: DispatchQueue,
        handler: @escaping (P.Output) -> Void
    ) where P.Failure == Never
}


//  MARK: - Default Implementation

extension Bindable {
    
    func subscribe<P: Publisher>(
        _ publisher: P,
        receiveOn scheduler: DispatchQueue = .main,
        handler: @escaping (P.Output) -> Void
    ) where P.Failure == Never {
        publisher
            .receive(on: scheduler)
            .sink(receiveValue: handler)
            .store(in: &cancellables)
    }
}
